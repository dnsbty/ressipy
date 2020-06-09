defmodule Ressipy.Recipes.Ingredient do
  use Ecto.Schema
  alias Ressipy.Recipes

  schema "ingredients" do
    field(:name, :string)

    many_to_many(:recipes, Recipes.Recipe, join_through: "recipe_ingredients")

    timestamps()
  end
end
