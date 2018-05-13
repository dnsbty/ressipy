defmodule Ressipy.Web.RecipeControllerTest do
  use Ressipy.Web.ConnCase

  alias Ressipy.Recipes

  @create_attrs %{author: "some author", default_image: "some default_image", name: "some name"}
  @update_attrs %{author: "some updated author", default_image: "some updated default_image", name: "some updated name"}
  @invalid_attrs %{author: nil, default_image: nil, name: nil}

  def fixture(:recipe) do
    {:ok, recipe} = Recipes.create_recipe(@create_attrs)
    recipe
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, recipe_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing Recipes"
  end

  @tag :skip
  test "renders form for new recipes", %{conn: conn} do
    conn = get conn, recipe_path(conn, :new)
    assert html_response(conn, 200) =~ "New Recipe"
  end

  @tag :skip
  test "creates recipe and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, recipe_path(conn, :create), recipe: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == recipe_path(conn, :show, id)

    conn = get conn, recipe_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Show Recipe"
  end

  @tag :skip
  test "does not create recipe and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, recipe_path(conn, :create), recipe: @invalid_attrs
    assert html_response(conn, 200) =~ "New Recipe"
  end

  @tag :skip
  test "renders form for editing chosen recipe", %{conn: conn} do
    recipe = fixture(:recipe)
    conn = get conn, recipe_path(conn, :edit, recipe)
    assert html_response(conn, 200) =~ "Edit Recipe"
  end

  @tag :skip
  test "updates chosen recipe and redirects when data is valid", %{conn: conn} do
    recipe = fixture(:recipe)
    conn = put conn, recipe_path(conn, :update, recipe), recipe: @update_attrs
    assert redirected_to(conn) == recipe_path(conn, :show, recipe)

    conn = get conn, recipe_path(conn, :show, recipe)
    assert html_response(conn, 200) =~ "some updated author"
  end

  @tag :skip
  test "does not update chosen recipe and renders errors when data is invalid", %{conn: conn} do
    recipe = fixture(:recipe)
    conn = put conn, recipe_path(conn, :update, recipe), recipe: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Recipe"
  end

  @tag :skip
  test "deletes chosen recipe", %{conn: conn} do
    recipe = fixture(:recipe)
    conn = delete conn, recipe_path(conn, :delete, recipe)
    assert redirected_to(conn) == recipe_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, recipe_path(conn, :show, recipe)
    end
  end
end
