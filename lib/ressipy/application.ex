defmodule Ressipy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    if Application.get_env(:ressipy, :start_verification_store, true) do
      Ressipy.SmsVerification.start()
    end

    children =
      if Application.get_env(:ressipy, :database_only, false) do
        [Ressipy.Repo]
      else
        [
          Ressipy.Repo,
          RessipyWeb.Telemetry,
          {Phoenix.PubSub, name: Ressipy.PubSub},
          RessipyWeb.Endpoint
        ]
      end

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
