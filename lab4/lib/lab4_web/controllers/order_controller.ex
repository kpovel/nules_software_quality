defmodule Lab4Web.OrderController do
  use Lab4Web, :controller

  alias Lab4.Account
  alias Lab4.BookOrders
  alias Lab4.Inventory.Book
  alias Lab4.Repo
  import Ecto.Query
  alias Lab4.Orders
  alias Lab4.Orders.Order

  action_fallback Lab4Web.FallbackController

  def index(conn, _params) do
    orders =
      from(o in Lab4.Orders.Order,
        join: bo in Lab4.BookOrders.BookOrder,
        on: o.id == bo.order_id,
        select: %{
          user_id: o.user_id,
          order: %{id: o.id, status: o.status},
          book: %{
            price: bo.book_price,
            book_id: bo.book_id,
            quantity: bo.quantity
          }
        }
      )
      |> Lab4.Repo.all()

    render(conn, :index, orders: orders)
  end

  def show(conn, %{"id" => id}) do
    orders =
      from(o in Lab4.Orders.Order,
        join: bo in Lab4.BookOrders.BookOrder,
        on: o.id == bo.order_id,
        where: o.id == ^id,
        select: %{
          user_id: o.user_id,
          order: %{id: o.id, status: o.status},
          book: %{
            price: bo.book_price,
            book_id: bo.book_id,
            quantity: bo.quantity
          }
        }
      )
      |> Lab4.Repo.all()

    render(conn, :show, orders: orders)
  end

  def user_orders(conn, %{"user_id" => user_id}) do
    orders =
      from(o in Lab4.Orders.Order,
        join: bo in Lab4.BookOrders.BookOrder,
        on: o.id == bo.order_id,
        where: o.user_id == ^user_id,
        select: %{
          user_id: o.user_id,
          order: %{id: o.id, status: o.status},
          book: %{
            price: bo.book_price,
            book_id: bo.book_id,
            quantity: bo.quantity
          }
        }
      )
      |> Lab4.Repo.all()

    render(conn, :index, orders: orders)
  end

  def create(conn, %{"books" => book_params, "user_id" => user_id}) do
    Account.get_user!(user_id)

    create_order_transaction =
      Repo.transaction(fn ->
        book_ids = book_params |> Enum.map(fn %{"book_id" => book_id} -> book_id end)

        books =
          from(b in Book,
            where: b.id in ^book_ids,
            select: %Book{id: b.id, price: b.price, quantity: b.quantity}
          )
          |> Repo.all()

        errors =
          Enum.reduce(book_params, [], fn %{"book_id" => book_id, "quantity" => quantity}, acc ->
            Enum.find(books, fn %Book{id: id} -> id == book_id end)
            |> case do
              nil ->
                ["Book with id #{book_id} doesn't exist" | acc]

              %Book{quantity: book_quantity} when book_quantity - quantity < 0 ->
                ["Book with id #{book_id} has only #{book_quantity} copies" | acc]

              %Book{} ->
                acc
            end
          end)

        case Enum.count(errors) == 0 do
          true ->
            Enum.map(book_params, fn %{"book_id" => book_id, "quantity" => quantity} ->
              Repo.query!(
                "
update books
set quantity = quantity - $1
where id = $2;",
                [quantity, book_id]
              )
            end)

            {:ok, %Order{id: order_id}} =
              Orders.create_order(%{
                status: :created,
                user_id: user_id
              })

            Enum.each(books, fn %Book{id: id, price: price} ->
              %{"book_id" => book_id, "quantity" => quantity} =
                Enum.find(book_params, fn %{"book_id" => book_id} ->
                  id == book_id
                end)

              BookOrders.create_book_order(%{
                book_price: price,
                order_id: order_id,
                book_id: book_id,
                quantity: quantity
              })
            end)

          false ->
            Repo.rollback(errors)
        end
      end)

    case create_order_transaction do
      {:ok, _} ->
        conn |> send_resp(200, "")

      {:error, errors} ->
        render(conn, :errors, errors: errors)
        |> put_status(400)
    end
  end

  def update(conn, %{"id" => id, "order_status" => order_status}) do
    order = Orders.get_order!(id)

    with {:ok, %Order{} = order} <-
           Orders.update_order(order, %{status: String.to_atom(order_status)}) do
      render(conn, :show, order: order)
    end
  end
end
