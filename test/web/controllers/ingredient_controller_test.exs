defmodule Ressipy.Web.IngredientControllerTest do
  use Ressipy.Web.ConnCase

  alias Ressipy.Recipes

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:ingredient) do
    {:ok, ingredient} = Recipes.create_ingredient(@create_attrs)
    ingredient
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, ingredient_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Ingredients"
  end

  test "renders form for new ingredients", %{conn: conn} do
    conn = get conn, ingredient_path(conn, :new)
    assert html_response(conn, 200) =~ "New Ingredient"
  end

  test "creates ingredient and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, ingredient_path(conn, :create), ingredient: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == ingredient_path(conn, :show, id)

    conn = get conn, ingredient_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Ingredient"
  end

  test "does not create ingredient and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, ingredient_path(conn, :create), ingredient: @invalid_attrs
    assert html_response(conn, 200) =~ "New Ingredient"
  end

  test "renders form for editing chosen ingredient", %{conn: conn} do
    ingredient = fixture(:ingredient)
    conn = get conn, ingredient_path(conn, :edit, ingredient)
    assert html_response(conn, 200) =~ "Edit Ingredient"
  end

  test "updates chosen ingredient and redirects when data is valid", %{conn: conn} do
    ingredient = fixture(:ingredient)
    conn = put conn, ingredient_path(conn, :update, ingredient), ingredient: @update_attrs
    assert redirected_to(conn) == ingredient_path(conn, :show, ingredient)

    conn = get conn, ingredient_path(conn, :show, ingredient)
    assert html_response(conn, 200) =~ "some updated name"
  end

  test "does not update chosen ingredient and renders errors when data is invalid", %{conn: conn} do
    ingredient = fixture(:ingredient)
    conn = put conn, ingredient_path(conn, :update, ingredient), ingredient: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Ingredient"
  end

  test "deletes chosen ingredient", %{conn: conn} do
    ingredient = fixture(:ingredient)
    conn = delete conn, ingredient_path(conn, :delete, ingredient)
    assert redirected_to(conn) == ingredient_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, ingredient_path(conn, :show, ingredient)
    end
  end
end
