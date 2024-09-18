defmodule Lab4Web.BookControllerTest do
  use Lab4Web.ConnCase

  import Lab4.InventoryFixtures

  alias Lab4.Inventory.Book

  @create_attrs %{
    name: "some name",
    description: "some description",
    author: "some author",
    price: 42,
    quantity: 42,
    isbn: "some isbn"
  }
  @update_attrs %{
    name: "some updated name",
    description: "some updated description",
    author: "some updated author",
    price: 43,
    quantity: 43,
    isbn: "some updated isbn"
  }
  @invalid_attrs %{name: nil, description: nil, author: nil, price: nil, quantity: nil, isbn: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all books", %{conn: conn} do
      conn = get(conn, ~p"/api/books")
      assert json_response(conn, 200) == []
    end
  end

  describe "create book" do
    test "renders book when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/books", book: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)

      conn = get(conn, ~p"/api/books/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some author",
               "description" => "some description",
               "isbn" => "some isbn",
               "name" => "some name",
               "price" => 42,
               "quantity" => 42
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/books", book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update book" do
    setup [:create_book]

    test "renders book when data is valid", %{conn: conn, book: %Book{id: id} = book} do
      conn = put(conn, ~p"/api/books/#{book}", book: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, ~p"/api/books/#{id}")

      assert %{
               "id" => ^id,
               "author" => "some updated author",
               "description" => "some updated description",
               "name" => "some updated name",
               "price" => 43,
               "quantity" => 43
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, book: book} do
      conn = put(conn, ~p"/api/books/#{book}", book: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete book" do
    setup [:create_book]

    test "deletes chosen book", %{conn: conn, book: book} do
      conn = delete(conn, ~p"/api/books/#{book}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/books/#{book}")
      end
    end
  end

  defp create_book(_) do
    book = book_fixture()
    %{book: book}
  end
end
