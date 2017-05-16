defmodule Ressipy.Repo.Migrations.CreateRessipy.Recipes.Instruction do
  use Ecto.Migration

  def change do
    create table(:instructions) do
      add :order, :integer
      add :text, :string
      add :recipe_id, references(:recipes, on_delete: :nothing)

      timestamps()
    end

    create index(:instructions, [:recipe_id])
  end
end
