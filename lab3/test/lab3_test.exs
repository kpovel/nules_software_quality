defmodule Lab3Test do
  alias Lab3.BookRanking
  alias Lab3.User
  alias Lab3.Book
  alias Lab3.Order
  use ExUnit.Case

  @book %Book{
    name: "foo",
    author: "author",
    isbn: "420-69",
    price: 123,
    quantity: 2
  }

  test "add book" do
    Book.add_book(@book)

    [
      %Book{
        name: "foo",
        author: "author",
        isbn: "420-69",
        price: 123,
        quantity: 2
      }
    ] = Lab3.Book.books()

    {:error, :duplicated_isbn} = Book.add_book(@book)
  end

  test "buy book" do
    %User{id: user_id} = User.create(%User{name: "Name"})

    Order.create(%Order{
      status: :processing,
      book_id: 1,
      user_id: user_id
    })

    [%Order{status: :processing, book_id: 1, user_id: ^user_id}] = Order.orders()
  end

  test "search book" do
    Book.add_book(%Book{
      name: "bar",
      author: "author2",
      isbn: "420-70",
      price: 23,
      quantity: 3
    })

    [
      %Book{
        name: "foo",
        author: "author",
        isbn: "420-69",
        price: 123,
        quantity: 2
      }
    ] = Book.search_by_name("foo")

    [
      %Book{
        name: "bar",
        author: "author2",
        isbn: "420-70",
        price: 23,
        quantity: 3
      }
    ] = Book.search_by_author("author2")

    %Book{
      name: "bar",
      author: "author2",
      isbn: "420-70",
      price: 23,
      quantity: 3
    } = Book.search_by_isbn("420-70")

    nil = Book.search_by_isbn("420-71")
  end

  test "book ranking" do
    BookRanking.create(%BookRanking{
      ranking: 2,
      book_id: 1,
      user_id: 1
    })

    BookRanking.create(%BookRanking{
      ranking: 5,
      book_id: 1,
      user_id: 1
    })

    3.5 = BookRanking.book_rank(1)
  end
end
