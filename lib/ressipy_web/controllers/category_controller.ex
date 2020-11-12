defmodule RessipyWeb.CategoryController do
  use RessipyWeb, :controller

  alias Ressipy.Recipes

  plug RessipyWeb.EnsureAuthenticated when action not in [:index, :show]

  def index(conn, _params) do
    categories = Recipes.list_categories()
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    changeset = Recipes.change_category(%Recipes.Category{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    case Recipes.create_category(category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Category created successfully.")
        |> redirect(to: Routes.category_path(conn, :show, category.slug))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"slug" => slug}) do
    category = Recipes.get_category!(slug)
    render(conn, "show.html", category: category)
  end

  def edit(conn, %{"slug" => slug}) do
    category = Recipes.get_category!(slug)
    changeset = Recipes.change_category(category)
    render(conn, "edit.html", category: category, changeset: changeset)
  end

  def update(conn, %{"slug" => slug, "category" => category_params}) do
    category = Recipes.get_category!(slug)

    case Recipes.update_category(category, category_params) do
      {:ok, category} ->
        conn
        |> put_flash(:info, "Category updated successfully.")
        |> redirect(to: Routes.category_path(conn, :show, category.slug))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", category: category, changeset: changeset)
    end
  end

  def delete(conn, %{"slug" => slug}) do
    category = Recipes.get_category!(slug)
    {:ok, _category} = Recipes.delete_category(category)

    conn
    |> put_flash(:info, "Category deleted successfully.")
    |> redirect(to: Routes.category_path(conn, :index))
  end
end
