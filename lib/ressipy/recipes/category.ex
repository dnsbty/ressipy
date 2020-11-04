defmodule Ressipy.Recipes.Category do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ressipy.Recipes

  @type t :: %__MODULE__{}

  schema "categories" do
    field(:name, :string)

    has_many(:recipes, Recipes.Recipe)

    timestamps()
  end

  @spec changeset(__MODULE__.t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = category, attrs) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, max: 255)
  end
end
