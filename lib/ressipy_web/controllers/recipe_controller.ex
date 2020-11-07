defmodule RessipyWeb.RecipeController do
  use RessipyWeb, :controller

  alias Ressipy.Recipes

  plug RessipyWeb.EnsureAuthenticated when action not in [:index, :show]

  def index(conn, _params) do
    recipes = Recipes.list_recipes()
    render(conn, "index.html", recipes: recipes)
  end

  def new(conn, params) do
    categories = Recipes.list_categories()

    selected_category =
      case params["category"] do
        nil -> nil
        category -> Enum.find(categories, &(&1.slug == category))
      end

    changeset = Recipes.empty_recipe(selected_category)

    assigns = [changeset: changeset, categories: categories, selected_category: selected_category]
    render(conn, "new.html", assigns)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    IO.inspect(recipe_params)

    case Recipes.create_recipe(recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe created successfully.")
        |> redirect(to: Routes.recipe_path(conn, :show, recipe.slug))

      {:error, %Ecto.Changeset{} = changeset} ->
        categories = Recipes.list_categories()
        render(conn, "new.html", changeset: changeset, categories: categories)
    end
  end

  def show(conn, %{"slug" => slug}) do
    recipe = Recipes.get_recipe!(slug)
    render(conn, "show.html", recipe: recipe)
  end

  def edit(conn, %{"slug" => slug}) do
    recipe = Recipes.get_recipe!(slug)
    categories = Recipes.list_categories()
    changeset = Recipes.change_recipe(recipe)
    render(conn, "edit.html", recipe: recipe, categories: categories, changeset: changeset)
  end

  def update(conn, %{"slug" => slug, "recipe" => recipe_params}) do
    recipe = Recipes.get_recipe!(slug)

    case Recipes.update_recipe(recipe, recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe updated successfully.")
        |> redirect(to: Routes.recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        categories = Recipes.list_categories()
        render(conn, "edit.html", recipe: recipe, categories: categories, changeset: changeset)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    recipe = Recipes.get_recipe!(slug)
    {:ok, _recipe} = Recipes.delete_recipe(recipe)

    conn
    |> put_flash(:info, "Recipe deleted successfully.")
    |> redirect(to: Routes.category_path(conn, :show, recipe.category.slug))
  end
end
