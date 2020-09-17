defmodule RessipyWeb.HealthController do
  use RessipyWeb, :controller

  def index(conn, _params) do
    json(conn, %{healthy: true})
  end
end
