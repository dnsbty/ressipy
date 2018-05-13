defmodule Ressipy.Repo.Migrations.CreateRessipy.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string, null: false, default: ""
      add :last_name, :string, null: false, default: ""
      add :phone, :string, null: false

      timestamps()
    end

    create unique_index(:users, [:phone])
  end
end
