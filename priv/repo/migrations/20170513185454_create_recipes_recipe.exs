defmodule Ressipy.Repo.Migrations.CreateRessipy.Recipes.Recipe do
  use Ecto.Migration

  def change do
    create table(:recipes) do
      add :name, :string
      add :author, :string
      add :default_image, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:recipes, [:category_id])
  end
end
