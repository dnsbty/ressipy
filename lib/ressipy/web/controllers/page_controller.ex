defmodule Ressipy.Web.PageController do
  use Ressipy.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
