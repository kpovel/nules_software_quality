defmodule Lab3.Repo.Migrations.Schema do
  use Ecto.Migration

  def change do
    create table (:book) do
      add :name, :string, null: false
      add :author, :string, null: false
      add :isbn, :string, null: false
      add :price, :integer, null: false
      add :quantity, :integer, null: false
    end

    create unique_index(:book, [:isbn])

    create table (:user) do
      add :name, :string, null: false
    end

    create table (:order) do
      add :book_id, references(:book)
      add :user_id, references(:user)
      add :status, :string, null: false
    end
  end
end
