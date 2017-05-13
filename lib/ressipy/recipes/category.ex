defmodule Ressipy.Recipes.Category do
  use Ecto.Schema

  schema "recipes_categories" do
    field :name, :string

    timestamps()
  end
end
