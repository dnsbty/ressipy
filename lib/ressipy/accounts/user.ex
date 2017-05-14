defmodule Ressipy.Accounts.User do
  use Ecto.Schema

  schema "accounts_accounts_users" do
    field :facebook_id, :string
    field :name, :string
    field :role_id, :id
    
    timestamps()
  end
end
