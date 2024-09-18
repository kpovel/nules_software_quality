defmodule Lab4Web.OrderJSON do
  def index(%{orders: orders}) do
    orders
    |> Enum.reduce([], &process_order/2)
    |> Enum.map(&calculate_total_price/1)
  end

  def show(%{orders: orders}) do
    orders =
      orders
      |> Enum.reduce([], &process_order/2)
      |> Enum.map(&calculate_total_price/1)

    List.first(orders)
  end

  defp process_order(order, acc) do
    %{
      user_id: user_id,
      order: %{id: order_id, status: order_status},
      book: %{price: _, book_id: _, quantity: _} = book
    } = order

    Enum.find_index(acc, fn %{order_id: id} -> id == order_id end)
    |> case do
      nil ->
        [
          %{
            user_id: user_id,
            order_id: order_id,
            order_status: order_status,
            books: [book]
          }
          | acc
        ]

      idx ->
        List.update_at(acc, idx, fn user_orders ->
          Map.update!(user_orders, :books, &[book | &1])
        end)
    end
  end

  def calculate_total_price(%{books: books} = order) do
    total_price =
      Enum.reduce(books, 0, fn %{price: price, quantity: quantity}, acc ->
        acc + quantity * price
      end)

    Map.put(order, :total_price, total_price)
  end

  def errors(%{errors: errors}), do: errors
end
