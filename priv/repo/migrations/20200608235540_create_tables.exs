defmodule Ressipy.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string

      timestamps()
    end

    create table(:ingredients) do
      add :name, :string

      timestamps()
    end

    create table(:recipes) do
      add :name, :string
      add :author, :string
      add :default_image, :string
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create table(:instructions) do
      add :order, :integer
      add :text, :string
      add :recipe_id, references(:recipes, on_delete: :nothing)

      timestamps()
    end

    create table(:recipe_ingredients) do
      add :amount, :string
      add :order, :integer
      add :recipe_id, references(:recipes, on_delete: :nothing)
      add :ingredient_id, references(:recipe_ingredients, on_delete: :nothing)

      timestamps()
    end

    create table(:users) do
      add :first_name, :string, null: false, default: ""
      add :last_name, :string, null: false, default: ""
      add :phone, :string, null: false

      timestamps()
    end

    create index(:recipes, [:category_id])
    create index(:instructions, [:recipe_id])
    create index(:recipe_ingredients, [:recipe_id])
    create index(:recipe_ingredients, [:ingredient_id])
    create unique_index(:users, [:phone])
  end
end
