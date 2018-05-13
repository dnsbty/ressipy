defmodule Ressipy.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    case Application.get_env(:camp_with_dennis, :environment) do
      :test -> nil
      _ -> SmsVerification.start()
    end

    children = [
      supervisor(Ressipy.Repo, []),
      supervisor(Ressipy.Web.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: Ressipy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
