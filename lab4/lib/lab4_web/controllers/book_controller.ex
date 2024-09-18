defmodule Lab4Web.BookController do
  use Lab4Web, :controller

  alias Lab4.Inventory
  alias Lab4.Inventory.Book

  action_fallback Lab4Web.FallbackController

  def index(conn, _params) do
    books = Inventory.list_books()
    render(conn, :index, books: books)
  end

  def create(conn, %{"book" => book_params}) do
    with {:ok, %Book{} = book} <- Inventory.create_book(book_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/books/#{book}")
      |> render(:show, book: book)
    end
  end

  def show(conn, %{"id" => id}) do
    book = Inventory.get_book!(id)
    render(conn, :show, book: book)
  end

  def update(conn, %{"id" => id, "book" => book_params}) do
    book = Inventory.get_book!(id)

    with {:ok, %Book{} = book} <- Inventory.update_book(book, book_params) do
      render(conn, :show, book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    book = Inventory.get_book!(id)

    with {:ok, %Book{}} <- Inventory.delete_book(book) do
      send_resp(conn, :no_content, "")
    end
  end
end
