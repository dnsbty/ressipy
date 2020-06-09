defmodule Ressipy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    if Application.get_env(:ressipy, :start_verification_store, true) do
      Ressipy.SmsVerification.start()
    end

    children = [
      # Start the Ecto repository
      Ressipy.Repo,
      # Start the Telemetry supervisor
      RessipyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ressipy.PubSub},
      # Start the Endpoint (http/https)
      RessipyWeb.Endpoint
      # Start a worker by calling: Ressipy.Worker.start_link(arg)
      # {Ressipy.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ressipy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RessipyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
