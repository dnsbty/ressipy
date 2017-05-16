defmodule Ressipy.Repo.Migrations.CreateRessipy.Accounts.Role do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string

      timestamps()
    end

  end
end
