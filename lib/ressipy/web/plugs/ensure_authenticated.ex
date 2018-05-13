defmodule Ressipy.Web.Plugs.EnsureAuthenticated do
  import Plug.Conn, only: [get_session: 2, halt: 1]
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def init(opts), do: opts

  def call(conn, _) do
    case get_session(conn, :user_id) do
      nil ->
        conn
        |> put_flash(:error, "You need to be logged in to do that.")
        |> redirect(to: "/login")
        |> halt()
      _user_id ->
        conn
    end
  end
end
