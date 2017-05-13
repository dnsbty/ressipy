defmodule Ressipy.Recipes.Instruction do
  use Ecto.Schema

  schema "recipes_instructions" do
    field :order, :integer
    field :text, :string

    belongs_to :recipes_recipes, Recipes.Recipe, foreign_key: :recipe_id

    timestamps()
  end
end
