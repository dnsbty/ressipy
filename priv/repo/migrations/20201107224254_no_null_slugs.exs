defmodule Ressipy.Repo.Migrations.NoNullSlugs do
  use Ecto.Migration

  def up do
    alter table(:categories) do
      modify(:name, :string, null: false)
      modify(:slug, :string, null: false)
    end

    alter table(:recipes) do
      modify(:name, :string, null: false)
      modify(:slug, :string, null: false)
    end
  end

  def down do
    alter table(:categories) do
      modify(:name, :string, null: true)
      modify(:slug, :string, null: true)
    end

    alter table(:recipes) do
      modify(:name, :string, null: true)
      modify(:slug, :string, null: true)
    end
  end
end
