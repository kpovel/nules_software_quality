defmodule Lab2.MixProject do
  use Mix.Project

  def project do
    [
      app: :lab2,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    config = [extra_applications: [:logger]]

    case Mix.env() == :test do
      true -> config
      false -> Keyword.put(config, :mod, {Lab2, []})
    end
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
