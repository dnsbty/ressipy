defmodule Ressipy.Recipes.Recipe do
  use Ecto.Schema

  schema "recipes_recipes" do
    field :author, :string
    field :default_image, :string
    field :name, :string
    field :category_id, :id

    timestamps()
  end
end
