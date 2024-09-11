defmodule Lab3.MixProject do
  use Mix.Project

  def project do
    [
      app: :lab3,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Lab3.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.10"},
      {:ecto_sqlite3, "~> 0.17"}
    ]
  end
end
