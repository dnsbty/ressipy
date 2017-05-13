defmodule Ressipy.Repo.Migrations.CreateRessipy.Recipes.Instruction do
  use Ecto.Migration

  def change do
    create table(:recipes_instructions) do
      add :order, :integer
      add :text, :string
      add :recipe_id, references(:recipes_recipes, on_delete: :nothing)

      timestamps()
    end

    create index(:recipes_instructions, [:recipe_id])
  end
end
