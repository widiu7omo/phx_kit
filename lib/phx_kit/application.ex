defmodule PhxKit.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PhxKitWeb.Telemetry,
      # Start the Ecto repository
      PhxKit.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhxKit.PubSub},
      # Start Finch
      {Finch, name: PhxKit.Finch},
      # Start the Endpoint (http/https)
      PhxKitWeb.Endpoint
      # Start a worker by calling: PhxKit.Worker.start_link(arg)
      # {PhxKit.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxKit.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxKitWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
