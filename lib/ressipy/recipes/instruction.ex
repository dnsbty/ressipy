defmodule Ressipy.Recipes.Instruction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ressipy.Recipes.Recipe

  @type t :: %__MODULE__{}

  schema "instructions" do
    field(:order, :integer)
    field(:text, :string)

    belongs_to(:recipe, Recipe)

    timestamps()
  end

  @spec changeset(__MODULE__.t(), map()) :: Ecto.Changeset.t()
  def changeset(%__MODULE__{} = instruction, attrs) do
    instruction
    |> cast(attrs, [:order, :text])
    |> validate_required([:order, :text])
    |> validate_length(:text, max: 255)
  end
end
