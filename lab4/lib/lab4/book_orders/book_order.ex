defmodule Lab4.BookOrders.BookOrder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "book_orders" do
    field :book_price, :integer
    field :quantity, :integer
    field :order_id, :id
    field :book_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book_order, attrs) do
    book_order
    |> cast(attrs, [:book_price, :order_id, :book_id, :quantity])
    |> validate_required([:book_price, :order_id, :book_id, :quantity])
  end
end
