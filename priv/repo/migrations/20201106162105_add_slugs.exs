defmodule Ressipy.Repo.Migrations.AddSlugs do
  use Ecto.Migration

  def change do
    alter table(:categories) do
      add(:slug, :string)
    end

    alter table(:recipes) do
      add(:slug, :string)
    end

    create(unique_index(:categories, [:slug]))
    create(unique_index(:recipes, [:slug]))
  end
end
