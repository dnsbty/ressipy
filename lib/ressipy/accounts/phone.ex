defmodule Ressipy.Accounts.Phone do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ressipy.Accounts

  @phone_error_message "number doesn't match the expected format (xxx) xxx-xxxx"

  @fields [
    :number
  ]

  embedded_schema do
    field :number, :string
  end

  @spec changeset(user :: map, attrs :: map) :: Ecto.Changeset.t()
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@fields)
    |> format_phone()
  end

  @spec format_phone(changeset :: Ecto.Changeset.t()) :: Ecto.Changeset.t()
  def format_phone(changeset) do
    number = get_field(changeset, :number) || ""

    case Accounts.format_phone(number) do
      nil -> add_error(changeset, :number, @phone_error_message)
      formatted -> put_change(changeset, :number, formatted)
    end
  end

  @spec number(changeset :: Ecto.Changeset.t()) :: String.t()
  def number(changeset) do
    changeset
    |> apply_changes()
    |> Map.get(:number)
  end
end
