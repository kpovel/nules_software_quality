import Config

config :lab3,
  ecto_repos: [Lab3.Repo]

config :logger, level: :warning

config :lab3, Lab3.Repo,
  database: Path.expand("../dev.db", __DIR__),
  pool_size: 5,
  stacktrace: true,
  show_sensitive_data_on_connection_error: true
