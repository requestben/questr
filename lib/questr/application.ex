defmodule Questr.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      QuestrWeb.Telemetry,
      # Start the Ecto repository
      Questr.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Questr.PubSub},
      # Start Finch
      {Finch, name: Questr.Finch},
      # Start the Endpoint (http/https)
      QuestrWeb.Endpoint
      # Start a worker by calling: Questr.Worker.start_link(arg)
      # {Questr.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Questr.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    QuestrWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
