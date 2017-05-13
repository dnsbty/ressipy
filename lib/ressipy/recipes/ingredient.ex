defmodule Ressipy.Recipes.Ingredient do
  use Ecto.Schema

  schema "recipes_ingredients" do
    field :name, :string

    many_to_many :recipes_recipes, Recipes.Recipe, join_through: "recipes_recipe_ingredients"

    timestamps()
  end
end
