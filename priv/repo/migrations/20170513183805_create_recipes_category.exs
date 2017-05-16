defmodule Ressipy.Repo.Migrations.CreateRessipy.Recipes.Category do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string

      timestamps()
    end

  end
end
