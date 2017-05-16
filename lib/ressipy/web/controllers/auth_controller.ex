defmodule Ressipy.Web.AuthController do
  use Ressipy.Web, :controller
  plug Ueberauth

  import Ecto.Query, only: [from: 2]
  require Logger
  alias Ressipy.{Accounts, Repo}
  alias Accounts.{User}

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    auth |> IO.inspect
    conn
    |> put_user(auth)
    |> put_flash(:info, "Welcome, #{auth.info.name}!")
    |> redirect(to: "/")
  end

  defp create_user_if_needed(nil, %{uid: facebook_id, info: %{name: name}}) do
    %{name: name, facebook_id: facebook_id}
    |> Accounts.create_user
  end

  defp create_user_if_needed(%User{} = user, _) do
    {:ok, user}
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  defp find_user(%Ueberauth.Auth{uid: facebook_id}) do
    Repo.one from u in User,
      where: u.facebook_id == ^facebook_id,
      preload: :role,
      limit: 1
  end

  defp put_user(conn, auth) do
    case auth |> find_user |> create_user_if_needed(auth) do
      {:ok, user} ->
        conn
        |> put_session(:current_user, user)
      _ ->
        Logger.error "User couldn't be created"
        conn
        |> put_flash(:error, "Could not create an account at the moment")
    end
  end
end