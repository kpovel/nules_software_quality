defmodule Lab3.Repo do
  use Ecto.Repo,
    otp_app: :lab3,
    adapter: Ecto.Adapters.SQLite3
end
