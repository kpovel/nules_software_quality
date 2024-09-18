defmodule Lab4.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Lab4.Account` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Lab4.Account.create_user()

    user
  end
end
