defmodule Lab4.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Lab4Web.Telemetry,
      Lab4.Repo,
      {Ecto.Migrator,
        repos: Application.fetch_env!(:lab4, :ecto_repos),
        skip: skip_migrations?()},
      {DNSCluster, query: Application.get_env(:lab4, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Lab4.PubSub},
      # Start a worker by calling: Lab4.Worker.start_link(arg)
      # {Lab4.Worker, arg},
      # Start to serve requests, typically the last entry
      Lab4Web.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lab4.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Lab4Web.Endpoint.config_change(changed, removed)
    :ok
  end

  defp skip_migrations?() do
    # By default, sqlite migrations are run when using a release
    System.get_env("RELEASE_NAME") != nil
  end
end
