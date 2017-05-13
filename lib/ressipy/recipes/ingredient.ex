defmodule Ressipy.Recipes.Ingredient do
  use Ecto.Schema

  schema "recipes_ingredients" do
    field :name, :string

    timestamps()
  end
end
