defmodule Lab3.Application do
  def start(_type, _args) do
    if Mix.env() == :test do
      System.cmd("mix", ["ecto.drop"])
      System.cmd("mix", ["ecto.create"])
      System.cmd("mix", ["ecto.migrate"])
    end

    children = [Lab3.Repo]

    opts = [strategy: :one_for_one, name: Lab3.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
