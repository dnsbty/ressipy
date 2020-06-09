defmodule Ressipy.Recipes.Recipe do
  use Ecto.Schema
  alias Ressipy.Recipes

  schema "recipes" do
    field(:author, :string)
    field(:default_image, :string)
    field(:name, :string)

    belongs_to(:category, Recipes.Category, foreign_key: :category_id)
    has_many(:instructions, Recipes.Instruction)
    has_many(:ingredients, Recipes.RecipeIngredient)

    timestamps()
  end
end
