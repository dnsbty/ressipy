defmodule Ressipy.Repo.Migrations.CascadeRecipeDeletion do
  use Ecto.Migration

  def up do
    execute("ALTER TABLE instructions DROP CONSTRAINT instructions_recipe_id_fkey")
    execute("ALTER TABLE recipe_ingredients DROP CONSTRAINT recipe_ingredients_recipe_id_fkey")

    alter table(:instructions) do
      modify(:recipe_id, references(:recipes, on_delete: :delete_all))
    end

    alter table(:recipe_ingredients) do
      modify(:recipe_id, references(:recipes, on_delete: :delete_all))
    end
  end

  def down do
    execute("ALTER TABLE instructions DROP CONSTRAINT instructions_recipe_id_fkey")
    execute("ALTER TABLE recipe_ingredients DROP CONSTRAINT recipe_ingredients_recipe_id_fkey")

    alter table(:instructions) do
      modify(:recipe_id, references(:recipes, on_delete: :nothing))
    end

    alter table(:recipe_ingredients) do
      modify(:recipe_id, references(:recipes, on_delete: :nothing))
    end
  end
end
