defmodule Ressipy.Recipes.Recipe do
  use Ecto.Schema

  schema "recipes_recipes" do
    field :author, :string
    field :default_image, :string
    field :name, :string
    field :category_id, :id
    has_many :recipes_ingredients, Ingredient

    timestamps()
  end
end
