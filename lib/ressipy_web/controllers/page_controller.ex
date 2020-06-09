defmodule RessipyWeb.PageController do
  use RessipyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
