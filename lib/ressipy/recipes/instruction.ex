defmodule Ressipy.Recipes.Instruction do
  use Ecto.Schema
  alias Ressipy.Recipes.Recipe

  schema "instructions" do
    field(:order, :integer)
    field(:text, :string)

    belongs_to(:recipe, Recipe)

    timestamps()
  end
end
