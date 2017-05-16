defmodule Ressipy.Accounts.User do
  use Ecto.Schema
  alias Ressipy.Accounts

  schema "users" do
    field :facebook_id, :string
    field :name, :string

    belongs_to :role, Accounts.Role, foreign_key: :role_id
    
    timestamps()
  end
end
