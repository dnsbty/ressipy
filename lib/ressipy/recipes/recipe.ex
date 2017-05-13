defmodule Ressipy.Recipes.Recipe do
  use Ecto.Schema

  schema "recipes_recipes" do
    field :author, :string
    field :default_image, :string
    field :name, :string

    belongs_to :recipes_categories, Recipes.Category, foreign_key: :category_id
    has_many :recipes_instructions, Recipes.Instruction
    many_to_many :recipes_ingredients, Recipes.Ingredient, join_through: "recipes_recipe_ingredients"

    timestamps()
  end
end
