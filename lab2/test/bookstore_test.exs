defmodule BookstoreTest do
  use ExUnit.Case
  doctest Bookstore

  test "create bookstore" do
    assert Bookstore.new() == []
  end

  test "add book" do
    books = Bookstore.new() |> Bookstore.add_book!("title", "author", 123, 2)
    expected = [%Book{title: "title", author: "author", price: 123, quantity: 2}]
    assert books == expected
  end

  test "search book" do
    books = Bookstore.new() |> Bookstore.add_book!("title", "author", 123, 2)
    book = books |> Bookstore.search_book("title")
    assert book == %Book{title: "title", author: "author", price: 123, quantity: 2}

    nil = books |> Bookstore.search_book("title@")
  end

  test "delete book" do
    books = Bookstore.new() |> Bookstore.add_book!("title", "author", 123, 2)

    books = books |> Bookstore.remove_book("title")
    assert books == []
  end

  test "purchase book" do
    books = Bookstore.new() |> Bookstore.add_book!("title", "author", 123, 2)

    {:ok, books, 246} = books |> Bookstore.purchase_book!("title", 2)
    expected = [%Book{title: "title", author: "author", price: 123, quantity: 0}]
    assert books == expected

    {:not_such_quantity} = books |> Bookstore.purchase_book!("title", 3)
    {:no_in_stock} = books |> Bookstore.purchase_book!("nil", 2)
  end

  test "inventory value" do
    books = Bookstore.new() |> Bookstore.add_book!("title", "author", 123, 2)
    246 = books |> Bookstore.inventory_value()
  end
end
