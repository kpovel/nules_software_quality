defmodule Lab4Web.UserJSON do
  alias Lab4.Account.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    for(user <- users, do: data(user))
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}), do: data(user)

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name
    }
  end
end
