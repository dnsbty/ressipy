defmodule Ressipy.Repo.Migrations.CreateRessipy.Recipes.Ingredient do
  use Ecto.Migration

  def change do
    create table(:recipes_ingredients) do
      add :name, :string

      timestamps()
    end

  end
end
