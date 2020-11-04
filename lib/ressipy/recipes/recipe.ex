defmodule Ressipy.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ressipy.Recipes.{
    Category,
    Instruction,
    RecipeIngredient
  }

  @type t :: %__MODULE__{}

  schema "recipes" do
    field(:author, :string)
    field(:default_image, :string)
    field(:name, :string)

    belongs_to(:category, Category, foreign_key: :category_id)
    has_many(:instructions, Instruction)
    has_many(:ingredients, RecipeIngredient)

    timestamps()
  end

  @spec changeset(__MODULE__.t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = recipe, attrs) do
    recipe
    |> cast(attrs, [:name, :author, :default_image, :category_id])
    |> cast_assoc(:instructions, required: true, with: &Instruction.changeset/2)
    |> cast_assoc(:ingredients, required: true, with: &RecipeIngredient.changeset/2)
    |> validate_required([:name, :category_id])
    |> validate_length(:author, max: 255)
    |> validate_length(:default_image, max: 255)
    |> validate_length(:name, max: 255)
  end
end
