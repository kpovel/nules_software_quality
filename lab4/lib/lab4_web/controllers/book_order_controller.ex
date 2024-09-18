defmodule Lab4Web.BookOrderController do
  use Lab4Web, :controller

  alias Lab4.BookOrders
  alias Lab4.BookOrders.BookOrder

  action_fallback Lab4Web.FallbackController

  def index(conn, _params) do
    book_orders = BookOrders.list_book_orders()
    render(conn, :index, book_orders: book_orders)
  end

  def create(conn, %{"book_order" => book_order_params}) do
    with {:ok, %BookOrder{} = book_order} <- BookOrders.create_book_order(book_order_params) do
      conn
      |> put_status(:created)
      |> render(:show, book_order: book_order)
    end
  end

  def show(conn, %{"id" => id}) do
    book_order = BookOrders.get_book_order!(id)
    render(conn, :show, book_order: book_order)
  end

  def update(conn, %{"id" => id, "book_order" => book_order_params}) do
    book_order = BookOrders.get_book_order!(id)

    with {:ok, %BookOrder{} = book_order} <- BookOrders.update_book_order(book_order, book_order_params) do
      render(conn, :show, book_order: book_order)
    end
  end

  def delete(conn, %{"id" => id}) do
    book_order = BookOrders.get_book_order!(id)

    with {:ok, %BookOrder{}} <- BookOrders.delete_book_order(book_order) do
      send_resp(conn, :no_content, "")
    end
  end
end
