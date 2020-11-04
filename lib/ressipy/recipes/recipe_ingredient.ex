defmodule Ressipy.Recipes.RecipeIngredient do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ressipy.Recipes.{
    Ingredient,
    Recipe
  }

  @type t :: %__MODULE__{}

  schema "recipe_ingredients" do
    field(:amount, :string)
    field(:order, :integer)

    belongs_to(:recipe, Recipe)
    belongs_to(:ingredient, Ingredient)

    timestamps()
  end

  @spec changeset(__MODULE__.t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = ingredient, attrs) do
    ingredient
    |> cast(attrs, [:amount, :order])
    |> cast_assoc(:ingredient, required: true, with: &Ingredient.changeset/2)
    |> validate_required([:amount, :order])
    |> validate_length(:amount, max: 255)
  end
end
