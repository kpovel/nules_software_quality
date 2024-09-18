defmodule Lab4.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lab4.Inventory` context.
  """

  @doc """
  Generate a unique book isbn.
  """
  def unique_book_isbn, do: "some isbn#{System.unique_integer([:positive])}"

  @doc """
  Generate a book.
  """
  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> Enum.into(%{
        author: "some author",
        description: "some description",
        isbn: unique_book_isbn(),
        name: "some name",
        price: 42,
        quantity: 42
      })
      |> Lab4.Inventory.create_book()

    book
  end
end
