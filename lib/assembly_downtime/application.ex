defmodule AssemblyDowntime.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AssemblyDowntimeWeb.Telemetry,
      AssemblyDowntime.Repo,
      {DNSCluster, query: Application.get_env(:assembly_downtime, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: AssemblyDowntime.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AssemblyDowntime.Finch},
      # Start a worker by calling: AssemblyDowntime.Worker.start_link(arg)
      # {AssemblyDowntime.Worker, arg},
      # Start to serve requests, typically the last entry
      AssemblyDowntimeWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AssemblyDowntime.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AssemblyDowntimeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
