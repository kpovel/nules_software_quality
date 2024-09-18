defmodule Lab4.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :status, Ecto.Enum, values: [:created, :paid, :sent, :received, :canceled]
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:status, :user_id])
    |> validate_required([:status, :user_id])
  end
end
