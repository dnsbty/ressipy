defmodule Ressipy.Recipes.RecipeIngredient do
  use Ecto.Schema

  schema "recipe_ingredients" do
    field :amount, :string
    field :order, :integer

    belongs_to :recipes, Recipes.Recipe
    belongs_to :ingredients, Recipes.Ingredient

    timestamps()
  end
end
