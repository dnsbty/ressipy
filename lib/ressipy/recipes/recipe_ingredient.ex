defmodule Ressipy.Recipes.RecipeIngredient do
  use Ecto.Schema

  schema "recipes_recipe_ingredients" do
    field :amount, :string
    field :order, :integer

    belongs_to :recipes_recipes, Recipes.Recipe, foreign_key: :recipe_id
    belongs_to :recipes_ingredients, Recipes.Ingredient, foreign_key: :ingredient_id

    timestamps()
  end
end
