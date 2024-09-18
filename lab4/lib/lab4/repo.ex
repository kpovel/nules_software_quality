defmodule Lab4.Repo do
  use Ecto.Repo,
    otp_app: :lab4,
    adapter: Ecto.Adapters.SQLite3
end
