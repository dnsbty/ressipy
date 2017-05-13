defmodule Ressipy.RecipesTest do
  use Ressipy.DataCase

  alias Ressipy.Recipes
  alias Ressipy.Recipes.Category

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:category, attrs \\ @create_attrs) do
    {:ok, category} = Recipes.create_category(attrs)
    category
  end

  test "list_categories/1 returns all categories" do
    category = fixture(:category)
    assert Recipes.list_categories() == [category]
  end

  test "get_category! returns the category with given id" do
    category = fixture(:category)
    assert Recipes.get_category!(category.id) == category
  end

  test "create_category/1 with valid data creates a category" do
    assert {:ok, %Category{} = category} = Recipes.create_category(@create_attrs)
    assert category.name == "some name"
  end

  test "create_category/1 with invalid data returns error changeset" do
    assert {:error, %Ecto.Changeset{}} = Recipes.create_category(@invalid_attrs)
  end

  test "update_category/2 with valid data updates the category" do
    category = fixture(:category)
    assert {:ok, category} = Recipes.update_category(category, @update_attrs)
    assert %Category{} = category
    assert category.name == "some updated name"
  end

  test "update_category/2 with invalid data returns error changeset" do
    category = fixture(:category)
    assert {:error, %Ecto.Changeset{}} = Recipes.update_category(category, @invalid_attrs)
    assert category == Recipes.get_category!(category.id)
  end

  test "delete_category/1 deletes the category" do
    category = fixture(:category)
    assert {:ok, %Category{}} = Recipes.delete_category(category)
    assert_raise Ecto.NoResultsError, fn -> Recipes.get_category!(category.id) end
  end

  test "change_category/1 returns a category changeset" do
    category = fixture(:category)
    assert %Ecto.Changeset{} = Recipes.change_category(category)
  end
end
