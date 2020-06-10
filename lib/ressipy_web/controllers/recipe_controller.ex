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

    changeset =
      %Recipes.Recipe{
        category_id: params["category"],
        ingredients: [
          %Recipes.RecipeIngredient{
            order: 1,
            ingredient: %Recipes.Ingredient{}
          }
        ],
        instructions: [%Recipes.Instruction{order: 1}]
      }
      |> Recipes.change_recipe()

    render(conn, "new.html", changeset: changeset, categories: categories)
  end

  def create(conn, %{"recipe" => recipe_params}) do
    IO.inspect(recipe_params)

    case Recipes.create_recipe(recipe_params) do
      {:ok, recipe} ->
        conn
        |> put_flash(:info, "Recipe created successfully.")
        |> redirect(to: Routes.recipe_path(conn, :show, recipe))

      {:error, %Ecto.Changeset{} = changeset} ->
        categories = Recipes.list_categories()
        render(conn, "new.html", changeset: changeset, categories: categories)
    end
  end

  def show(conn, %{"id" => id}) do
    recipe = Recipes.get_recipe!(id)
    render(conn, "show.html", recipe: recipe)
  end

  def edit(conn, %{"id" => id}) do
    recipe = Recipes.get_recipe!(id)
    categories = Recipes.list_categories()
    changeset = Recipes.change_recipe(recipe)
    render(conn, "edit.html", recipe: recipe, categories: categories, changeset: changeset)
  end

  def update(conn, %{"id" => id, "recipe" => recipe_params}) do
    recipe = Recipes.get_recipe!(id)

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

  def delete(conn, %{"id" => id}) do
    recipe = Recipes.get_recipe!(id)
    {:ok, _recipe} = Recipes.delete_recipe(recipe)

    conn
    |> put_flash(:info, "Recipe deleted successfully.")
    |> redirect(to: Routes.recipe_path(conn, :index))
  end
end
