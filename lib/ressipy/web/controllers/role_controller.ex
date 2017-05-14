defmodule Ressipy.Web.RoleController do
  use Ressipy.Web, :controller

  alias Ressipy.Accounts

  def index(conn, _params) do
    accounts_roles = Accounts.list_accounts_roles()
    render(conn, "index.html", accounts_roles: accounts_roles)
  end

  def new(conn, _params) do
    changeset = Accounts.change_role(%Ressipy.Accounts.Role{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"role" => role_params}) do
    case Accounts.create_role(role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role created successfully.")
        |> redirect(to: role_path(conn, :show, role))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Accounts.get_role!(id)
    render(conn, "show.html", role: role)
  end

  def edit(conn, %{"id" => id}) do
    role = Accounts.get_role!(id)
    changeset = Accounts.change_role(role)
    render(conn, "edit.html", role: role, changeset: changeset)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Accounts.get_role!(id)

    case Accounts.update_role(role, role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role updated successfully.")
        |> redirect(to: role_path(conn, :show, role))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", role: role, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Accounts.get_role!(id)
    {:ok, _role} = Accounts.delete_role(role)

    conn
    |> put_flash(:info, "Role deleted successfully.")
    |> redirect(to: role_path(conn, :index))
  end
end
