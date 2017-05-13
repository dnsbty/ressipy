defmodule Ressipy.Recipes.Instruction do
  use Ecto.Schema

  schema "instructions" do
    field :order, :integer
    field :text, :string

    belongs_to :recipes, Recipes.Recipe

    timestamps()
  end
end
