defmodule Lab4.BookOrders do
  @moduledoc """
  The BookOrders context.
  """

  import Ecto.Query, warn: false
  alias Lab4.Repo

  alias Lab4.BookOrders.BookOrder

  @doc """
  Returns the list of book_orders.

  ## Examples

      iex> list_book_orders()
      [%BookOrder{}, ...]

  """
  def list_book_orders do
    Repo.all(BookOrder)
  end

  @doc """
  Gets a single book_order.

  Raises `Ecto.NoResultsError` if the Book order does not exist.

  ## Examples

      iex> get_book_order!(123)
      %BookOrder{}

      iex> get_book_order!(456)
      ** (Ecto.NoResultsError)

  """
  def get_book_order!(id), do: Repo.get!(BookOrder, id)

  @doc """
  Creates a book_order.

  ## Examples

      iex> create_book_order(%{field: value})
      {:ok, %BookOrder{}}

      iex> create_book_order(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_book_order(attrs \\ %{}) do
    %BookOrder{}
    |> BookOrder.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a book_order.

  ## Examples

      iex> update_book_order(book_order, %{field: new_value})
      {:ok, %BookOrder{}}

      iex> update_book_order(book_order, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_book_order(%BookOrder{} = book_order, attrs) do
    book_order
    |> BookOrder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a book_order.

  ## Examples

      iex> delete_book_order(book_order)
      {:ok, %BookOrder{}}

      iex> delete_book_order(book_order)
      {:error, %Ecto.Changeset{}}

  """
  def delete_book_order(%BookOrder{} = book_order) do
    Repo.delete(book_order)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book_order changes.

  ## Examples

      iex> change_book_order(book_order)
      %Ecto.Changeset{data: %BookOrder{}}

  """
  def change_book_order(%BookOrder{} = book_order, attrs \\ %{}) do
    BookOrder.changeset(book_order, attrs)
  end
end
