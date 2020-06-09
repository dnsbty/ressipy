defmodule Ressipy.Accounts.Verification do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ressipy.SmsVerification

  @fields [
    :code,
    :number
  ]

  @code_format ~r"\d{6}"
  @phone_format ~r"^\+1\d{10}$"
  @code_error_message "does not match the one sent to your phone number"

  @primary_key false
  embedded_schema do
    field :code, :string
    field :number, :string
  end

  @spec changeset(struct :: map, params :: map) :: Ecto.Changeset.t()
  def changeset(struct, params) do
    struct
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_format(:code, @code_format, message: "should be 6-digits long")
    |> validate_format(:number, @phone_format, message: "was not provided")
    |> verify_code()
  end

  @spec phone_number(changeset :: Ecto.Changeset.t()) :: String.t()
  def phone_number(changeset) do
    changeset
    |> apply_changes()
    |> Map.get(:number)
  end

  @spec verify_code(changeset :: Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp verify_code(%{valid?: false} = changeset), do: changeset

  defp verify_code(changeset) do
    phone = get_field(changeset, :number)
    code = get_field(changeset, :code)

    case SmsVerification.verify(phone, code) do
      :error -> add_error(changeset, :code, @code_error_message)
      :ok -> changeset
    end
  end
end
