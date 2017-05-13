defmodule Ressipy.Repo.Migrations.CreateRessipy.Recipes.RecipeIngredient do
  use Ecto.Migration

  def change do
    create table(:recipes_recipe_ingredients) do
      add :amount, :string
      add :order, :integer
      add :recipe_id, references(:recipes_recipes, on_delete: :nothing)
      add :ingredient_id, references(:recipes_ingredients, on_delete: :nothing)

      timestamps()
    end

    create index(:recipes_recipe_ingredients, [:recipe_id])
    create index(:recipes_recipe_ingredients, [:ingredient_id])
  end
end
