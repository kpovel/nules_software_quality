defmodule Lab4Web.BookOrderJSON do
  alias Lab4.BookOrders.BookOrder

  @doc """
  Renders a list of book_orders.
  """
  def index(%{book_orders: book_orders}) do
    %{data: for(book_order <- book_orders, do: data(book_order))}
  end

  @doc """
  Renders a single book_order.
  """
  def show(%{book_order: book_order}) do
    %{data: data(book_order)}
  end

  defp data(%BookOrder{} = book_order) do
    %{
      id: book_order.id,
      book_price: book_order.book_price
    }
  end
end
