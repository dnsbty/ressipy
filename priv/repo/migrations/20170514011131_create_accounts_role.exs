defmodule Ressipy.Repo.Migrations.CreateRessipy.Accounts.Role do
  use Ecto.Migration

  def change do
    create table(:accounts_roles) do
      add :name, :string

      timestamps()
    end

  end
end
