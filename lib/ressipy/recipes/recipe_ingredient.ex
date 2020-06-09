defmodule Ressipy.Recipes.RecipeIngredient do
  use Ecto.Schema
  alias Ressipy.Recipes

  schema "recipe_ingredients" do
    field(:amount, :string)
    field(:order, :integer)

    belongs_to(:recipe, Recipes.Recipe)
    belongs_to(:ingredient, Recipes.Ingredient)

    timestamps()
  end
end
