defmodule Ressipy.Recipes.Ingredient do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ressipy.Recipes.Recipe

  @type t :: %__MODULE__{}

  schema "ingredients" do
    field(:name, :string)

    many_to_many(:recipes, Recipe, join_through: "recipe_ingredients")

    timestamps()
  end

  @spec changeset(__MODULE__.t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = ingredient, attrs) do
    ingredient
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, max: 255)
  end
end
