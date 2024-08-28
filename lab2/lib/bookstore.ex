defmodule Book do
  defstruct title: nil, author: nil, price: nil, quantity: nil
end

defmodule Bookstore do
  use ExUnit.Case
  @spec new() :: list(%Book{})
  def new(), do: []

  @spec add_book!(list(%Book{}), %Book{}) :: list(%Book{})
  def add_book!(books, %Book{} = book) do
    assert book.price >= 0
    assert book.quantity >= 0
    [book | books]
  end

  @spec add_book!(list(%Book{}), String.t(), String.t(), String.t(), String.t()) :: list(%Book{})
  def add_book!(books, title, author, price, quantity) do
    book = %Book{
      title: title,
      author: author,
      price: price,
      quantity: quantity
    }

    books |> add_book!(book)
  end

  @spec remove_book(list(%Book{}), String.t()) :: list(%Book{})
  def remove_book(books, title) do
    book_idx = books |> Enum.find_index(fn %Book{title: t} -> t == title end)

    case book_idx do
      nil -> books
      idx -> books |> List.delete_at(idx)
    end
  end

  @spec search_book(list(%Book{}), String.t()) :: %Book{} | nil
  def search_book(books, title) do
    books |> Enum.find(fn %Book{title: t} -> t == title end)
  end

  @spec purchase_book!(list(%Book{}), String.t(), integer) ::
          {:no_in_stock}
          | {:not_such_quantity}
          | {:ok, list(%Book{}), float}
  def purchase_book!(books, title, quantity) do
    assert quantity >= 1

    book = books |> search_book(title)

    case book do
      nil ->
        {:no_in_stock}

      %Book{quantity: qty} when quantity > qty ->
        {:not_such_quantity}

      %Book{title: title, price: price} = book ->
        book = update_in(book.quantity, &(&1 - quantity))
        books = books |> remove_book(title) |> add_book!(book)
        {:ok, books, price * quantity}
    end
  end

  @spec inventory_value(list(%Book{})) :: float
  def inventory_value(books) do
    books
    |> Stream.map(fn %Book{price: price, quantity: quantity} ->
      price * quantity
    end)
    |> Enum.sum()
  end
end
