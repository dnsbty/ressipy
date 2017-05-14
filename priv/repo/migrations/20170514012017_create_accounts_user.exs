defmodule Ressipy.Repo.Migrations.CreateRessipy.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_accounts_users) do
      add :facebook_id, :string
      add :name, :string
      add :role_id, references(:accounts_roles, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:accounts_accounts_users, [:facebook_id])
    create index(:accounts_accounts_users, [:role_id])
  end
end
