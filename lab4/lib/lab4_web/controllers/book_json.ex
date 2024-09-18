defmodule Lab4Web.BookJSON do
  alias Lab4.Inventory.Book

  @doc """
  Renders a list of books.
  """
  def index(%{books: books}) do
    for(book <- books, do: data(book))
  end

  @doc """
  Renders a single book.
  """
  def show(%{book: book}), do: data(book)

  defp data(%Book{} = book) do
    %{
      id: book.id,
      name: book.name,
      description: book.description,
      author: book.author,
      price: book.price,
      quantity: book.quantity,
      isbn: book.isbn
    }
  end
end
