defmodule Lab3.Book do
  use Ecto.Schema
  alias Lab3.Book
  alias Lab3.Repo
  alias Ecto.Changeset
  import Ecto.Query

  schema "book" do
    field(:name, :string)
    field(:author, :string)
    field(:isbn, :string)
    field(:price, :integer)
    field(:quantity, :integer)
  end

  def changeset(book, params \\ %{}) do
    book
    |> Changeset.cast(params, [:name, :author, :isbn, :price, :quantity])
    |> Changeset.validate_required([:name, :author, :isbn, :price, :quantity])
    |> Changeset.unique_constraint(:isbn)
  end

  def books() do
    Book |> Repo.all()
  end

  def add_book(%Book{} = book) do
    unique_isbn =
      from(Book,
        where: [isbn: ^book.isbn],
        select: [:id]
      )
      |> Repo.all()
      |> Enum.empty?()

    case unique_isbn do
      true -> book |> Repo.insert!()
      false -> {:error, :duplicated_isbn}
    end
  end

  def search_by_name(name) do
    from(Book,
      where: [name: ^name],
      select: [
        :name,
        :author,
        :isbn,
        :price,
        :quantity
      ]
    )
    |> Repo.all()
  end

  def search_by_author(author) do
    from(Book,
      where: [author: ^author],
      select: [
        :name,
        :author,
        :isbn,
        :price,
        :quantity
      ]
    )
    |> Repo.all()
  end

  def search_by_isbn(isbn) do
    from(Book,
      where: [isbn: ^isbn],
      select: [
        :name,
        :author,
        :isbn,
        :price,
        :quantity
      ]
    )
    |> Repo.one()
  end
end
