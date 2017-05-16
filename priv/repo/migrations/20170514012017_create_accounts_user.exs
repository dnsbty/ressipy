defmodule Ressipy.Repo.Migrations.CreateRessipy.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :facebook_id, :string
      add :name, :string
      add :role_id, references(:roles, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:users, [:facebook_id])
    create index(:users, [:role_id])
  end
end
