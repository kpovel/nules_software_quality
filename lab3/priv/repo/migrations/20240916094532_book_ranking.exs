defmodule Lab3.Repo.Migrations.BookRanking do
  use Ecto.Migration

  def change do
    create table (:book_ranking) do
      add :book_id, references(:book)
      add :user_id, references(:user)
      add :ranking, :integer, null: false
    end
  end
end
