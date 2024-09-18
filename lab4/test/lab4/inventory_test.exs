defmodule Lab4.InventoryTest do
  use Lab4.DataCase

  alias Lab4.Inventory

  describe "books" do
    alias Lab4.Inventory.Book

    import Lab4.InventoryFixtures

    @invalid_attrs %{name: nil, description: nil, author: nil, price: nil, quantity: nil, isbn: nil}

    test "list_books/0 returns all books" do
      book = book_fixture()
      assert Inventory.list_books() == [book]
    end

    test "get_book!/1 returns the book with given id" do
      book = book_fixture()
      assert Inventory.get_book!(book.id) == book
    end

    test "create_book/1 with valid data creates a book" do
      valid_attrs = %{name: "some name", description: "some description", author: "some author", price: 42, quantity: 42, isbn: "some isbn"}

      assert {:ok, %Book{} = book} = Inventory.create_book(valid_attrs)
      assert book.name == "some name"
      assert book.description == "some description"
      assert book.author == "some author"
      assert book.price == 42
      assert book.quantity == 42
      assert book.isbn == "some isbn"
    end

    test "create_book/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_book(@invalid_attrs)
    end

    test "update_book/2 with valid data updates the book" do
      book = book_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", author: "some updated author", price: 43, quantity: 43, isbn: "some updated isbn"}

      assert {:ok, %Book{} = book} = Inventory.update_book(book, update_attrs)
      assert book.name == "some updated name"
      assert book.description == "some updated description"
      assert book.author == "some updated author"
      assert book.price == 43
      assert book.quantity == 43
      assert book.isbn == "some updated isbn"
    end

    test "update_book/2 with invalid data returns error changeset" do
      book = book_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_book(book, @invalid_attrs)
      assert book == Inventory.get_book!(book.id)
    end

    test "delete_book/1 deletes the book" do
      book = book_fixture()
      assert {:ok, %Book{}} = Inventory.delete_book(book)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_book!(book.id) end
    end

    test "change_book/1 returns a book changeset" do
      book = book_fixture()
      assert %Ecto.Changeset{} = Inventory.change_book(book)
    end
  end
end
