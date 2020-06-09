defmodule Ressipy.Repo do
  use Ecto.Repo,
    otp_app: :ressipy,
    adapter: Ecto.Adapters.Postgres
end
