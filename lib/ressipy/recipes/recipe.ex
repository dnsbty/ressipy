defmodule Ressipy.Recipes.Recipe do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ressipy.Recipes.{
    Category,
    Instruction,
    RecipeIngredient
  }

  alias Ressipy.Util

  @type t :: %__MODULE__{}

  schema "recipes" do
    field(:author, :string)
    field(:default_image, :string)
    field(:name, :string)
    field(:slug, :string)

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
    |> put_slug()
    |> validate_required([:name, :category_id])
    |> validate_length(:author, max: 255)
    |> validate_length(:default_image, max: 255)
    |> validate_length(:name, max: 255)
    |> unique_constraint(:slug)
  end

  @spec put_slug(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp put_slug(changeset) do
    case fetch_change(changeset, :name) do
      {:ok, name} ->
        slug = Util.slugify(name)
        put_change(changeset, :slug, slug)

      :error ->
        changeset
    end
  end
end
