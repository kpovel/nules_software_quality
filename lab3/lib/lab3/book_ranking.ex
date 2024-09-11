defmodule Lab3.BookRanking do
  use Ecto.Schema
  alias Lab3.BookRanking
  # alias Lab3.Book
  alias Ecto.Changeset
  alias Lab3.Repo

  schema "book_ranking" do
    field(:ranking, :integer)
    field(:book_id, :integer)
    field(:user_id, :integer)
  end

  def changeset(ranking, params \\ %{}) do
    ranking
    |> Changeset.cast(params, [:status])
    |> Changeset.validate_required([:status])
  end

  def create(%BookRanking{} = book_ranking)
      when book_ranking.ranking < 1 or book_ranking.ranking > 5 do
    {:error, :invalid_ranking_range}
  end

  def create(%BookRanking{} = book_ranking) do
    book_ranking |> Repo.insert!()
  end

  def book_rank(book_id) do
    %Exqlite.Result{
      rows: [[rank]]
    } =
      Repo.query!("select avg(ranking) from book_ranking where book_id = $1;", [book_id])

    rank
  end
end
