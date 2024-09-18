defmodule Lab4.Repo.Migrations.CreateBookOrders do
  use Ecto.Migration

  def change do
    create table(:book_orders) do
      add :book_price, :integer
      add :quantity, :integer
      add :order_id, references(:orders, on_delete: :nothing)
      add :book_id, references(:books, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:book_orders, [:order_id])
    create index(:book_orders, [:book_id])
  end
end
