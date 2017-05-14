defmodule Ressipy.Web.RoleControllerTest do
  use Ressipy.Web.ConnCase

  alias Ressipy.Accounts

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:role) do
    {:ok, role} = Accounts.create_role(@create_attrs)
    role
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, role_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Accounts roles"
  end

  test "renders form for new accounts_roles", %{conn: conn} do
    conn = get conn, role_path(conn, :new)
    assert html_response(conn, 200) =~ "New Role"
  end

  test "creates role and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, role_path(conn, :create), role: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == role_path(conn, :show, id)

    conn = get conn, role_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Role"
  end

  test "does not create role and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, role_path(conn, :create), role: @invalid_attrs
    assert html_response(conn, 200) =~ "New Role"
  end

  test "renders form for editing chosen role", %{conn: conn} do
    role = fixture(:role)
    conn = get conn, role_path(conn, :edit, role)
    assert html_response(conn, 200) =~ "Edit Role"
  end

  test "updates chosen role and redirects when data is valid", %{conn: conn} do
    role = fixture(:role)
    conn = put conn, role_path(conn, :update, role), role: @update_attrs
    assert redirected_to(conn) == role_path(conn, :show, role)

    conn = get conn, role_path(conn, :show, role)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen role and renders errors when data is invalid", %{conn: conn} do
    role = fixture(:role)
    conn = put conn, role_path(conn, :update, role), role: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Role"
  end

  test "deletes chosen role", %{conn: conn} do
    role = fixture(:role)
    conn = delete conn, role_path(conn, :delete, role)
    assert redirected_to(conn) == role_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, role_path(conn, :show, role)
    end
  end
end
