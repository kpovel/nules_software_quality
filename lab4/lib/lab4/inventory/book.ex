defmodule Lab4.Inventory.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :name, :string
    field :description, :string
    field :author, :string
    field :price, :integer
    field :quantity, :integer
    field :isbn, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:name, :description, :author, :price, :quantity, :isbn])
    |> validate_required([:name, :description, :author, :price, :quantity, :isbn])
    |> unique_constraint(:isbn)
  end
end
