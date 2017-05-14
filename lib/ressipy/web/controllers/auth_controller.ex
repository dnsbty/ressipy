defmodule Ressipy.Web.AuthController do
  use Ressipy.Web, :controller
  plug Ueberauth

  import Ecto.Query, only: [from: 2]
  alias Ressipy.Accounts
  alias Ressipy.Accounts.Role
  alias Ressipy.Accounts.User
  alias Ressipy.Repo

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

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  defp create_user(%{uid: facebook_id, info: %{name: name}}) do
    role_name = Application.get_env(:ressipy, :default_role)
    role_id = case Repo.all from role in Role, where: role.name == ^role_name do
      [%Role{id: id} | _] -> id
      _ -> raise "Could not find a role named #{role_name}"
    end
    %{name: name, facebook_id: facebook_id, role_id: role_id}
    |> Accounts.create_user
  end

  defp find_user(auth) do
    case Repo.all from user in User, where: user.facebook_id == ^auth.uid do
      [%User{} = user | _] -> user
      _ -> nil
    end
  end

  defp put_user(conn, auth) do
    user = case find_user(auth) do
      %User{} = user ->
        user
      _ ->
        case create_user(auth) do
          {:ok, %User{} = user} ->
            user
          {:error, %Ecto.Changeset{} = changeset} ->
            IO.inspect changeset
            raise "Could not create user"
        end
    end
    conn
    |> put_session(:current_user, user)
  end
end