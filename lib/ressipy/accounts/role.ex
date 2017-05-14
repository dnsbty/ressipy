defmodule Ressipy.Accounts.Role do
  use Ecto.Schema

  schema "accounts_roles" do
    field :name, :string

    timestamps()
  end
end
