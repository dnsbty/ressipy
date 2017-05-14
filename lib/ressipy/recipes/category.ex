defmodule Ressipy.Recipes.Category do
  use Ecto.Schema
  alias Ressipy.Recipes

  schema "categories" do
    field :name, :string

    has_many :recipes, Recipes.Recipe

    timestamps()
  end
end
