defmodule Lab4.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :name, :string
      add :description, :string
      add :author, :string
      add :price, :integer
      add :quantity, :integer
      add :isbn, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:books, [:isbn])
  end
end
