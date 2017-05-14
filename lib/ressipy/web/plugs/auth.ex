defmodule Ressipy.Web.Plugs.Auth do
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn

  alias Ressipy.Accounts.Role
  alias Ressipy.Accounts.User

  def init(roles_with_access), do: roles_with_access

  def call(conn, nil), do: conn

  def call(conn, []), do: deny(conn, :forbidden)

  def call(conn, roles_with_access) do
    case get_session(conn, :current_user) do
      nil ->
        deny(conn, :unauthorized)
      %User{role: %Role{name: role}} ->
        if Enum.any? roles_with_access, &(&1 == role) do
          conn
        else
          deny(conn, :forbidden)
        end
    end
  end

  defp deny(conn, :forbidden) do
    conn
    |> put_flash(:error, "You don't have access to this page")
    |> redirect(to: "/")
    |> halt
  end

  defp deny(conn, :unauthorized) do
    conn
    |> put_flash(:error, "Please login to view this page")
    |> redirect(to: "/")
    |> halt
  end
end