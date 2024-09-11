defmodule Lab3.Order do
  use Ecto.Schema
  alias Lab3.Order
  alias Ecto.Changeset
  alias Lab3.Repo

  schema "order" do
    field(:status, Ecto.Enum, values: [:processing, :sent, :received])
    field(:book_id, :integer)
    field(:user_id, :integer)
  end

  def changeset(order, params \\ %{}) do
    order
    |> Changeset.cast(params, [:status])
    |> Changeset.validate_required([:status])
  end

  def orders() do
    Order |> Repo.all()
  end

  def create(%Order{} = order) do
    order |> Repo.insert!()
  end
end
