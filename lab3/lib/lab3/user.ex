defmodule Lab3.User do
  use Ecto.Schema
  alias Lab3.User
  alias Ecto.Changeset
  alias Lab3.Repo

  schema "user" do
    field(:name, :string)
  end

  def changeset(user, params \\ %{}) do
    user
    |> Changeset.cast(params, [:name])
    |> Changeset.validate_required([:name])
  end

  def users() do
    User |> Repo.all()
  end

  def create(%User{} = user) do
    user |> Repo.insert!()
  end
end
