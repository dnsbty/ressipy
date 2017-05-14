defmodule Ressipy.AccountsTest do
  use Ressipy.DataCase

  alias Ressipy.Accounts
  alias Ressipy.Accounts.Role

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:role, attrs \\ @create_attrs) do
    {:ok, role} = Accounts.create_role(attrs)
    role
  end

  test "list_accounts_roles/1 returns all accounts_roles" do
    role = fixture(:role)
    assert Accounts.list_accounts_roles() == [role]
  end

  test "get_role! returns the role with given id" do
    role = fixture(:role)
    assert Accounts.get_role!(role.id) == role
  end

  test "create_role/1 with valid data creates a role" do
    assert {:ok, %Role{} = role} = Accounts.create_role(@create_attrs)
    assert role.name == "some name"
  end

  test "create_role/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Accounts.create_role(@invalid_attrs)
  end

  test "update_role/2 with valid data updates the role" do
    role = fixture(:role)
    assert {:ok, role} = Accounts.update_role(role, @update_attrs)
    assert %Role{} = role
    assert role.name == "some updated name"
  end

  test "update_role/2 with invalid data returns error changeset" do
    role = fixture(:role)
    assert {:error, %Ecto.Changeset{}} = Accounts.update_role(role, @invalid_attrs)
    assert role == Accounts.get_role!(role.id)
  end

  test "delete_role/1 deletes the role" do
    role = fixture(:role)
    assert {:ok, %Role{}} = Accounts.delete_role(role)
    assert_raise Ecto.NoResultsError, fn -> Accounts.get_role!(role.id) end
  end

  test "change_role/1 returns a role changeset" do
    role = fixture(:role)
    assert %Ecto.Changeset{} = Accounts.change_role(role)
  end
end
