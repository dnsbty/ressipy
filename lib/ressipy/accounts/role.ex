defmodule Ressipy.Accounts.Role do
  use Ecto.Schema
  alias Ressipy.Accounts

  schema "accounts_roles" do
    field :name, :string

    has_many :users, Accounts.User

    timestamps()
  end
end
