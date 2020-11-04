defmodule Ressipy.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ressipy.Accounts

  @phone_error_message "number doesn't match the expected format (xxx) xxx-xxxx"

  @fields [
    :first_name,
    :last_name,
    :phone
  ]

  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:phone, :string)

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> validate_length(:first_name, max: 255)
    |> validate_length(:last_name, max: 255)
    |> format_phone()
    |> unique_constraint(:phone, name: :users_phone_index)
  end

  def format_phone(changeset) do
    number = get_field(changeset, :phone) || ""

    case Accounts.format_phone(number) do
      nil -> add_error(changeset, :phone, @phone_error_message)
      formatted -> put_change(changeset, :phone, formatted)
    end
  end
end
