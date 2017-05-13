defmodule Ressipy.Recipes.Instruction do
  use Ecto.Schema

  schema "recipes_instructions" do
    field :order, :integer
    field :text, :string
    field :recipe_id, :id

    timestamps()
  end
end
