defmodule Ressipy.Accounts do
  require Logger
  alias Ressipy.Repo
  alias Ressipy.Accounts.{
    Phone,
    User,
    Verification
  }

  @phone_regex ~r"^\((\d{3})\) (\d{3})-(\d{4})$"

  @spec format_phone(number :: String.t) :: String.t | nil
  def format_phone(number) when is_binary(number) do
    with [_ | parts] <- Regex.run(@phone_regex, number) do
      "+1#{Enum.join(parts)}"
    end
  end

  @spec get_user_with_phone(number :: String.t) :: User.t | nil
  def get_user_with_phone("(" <> _ = number) do
    number
    |> format_phone
    |> get_user_with_phone
  end

  def get_user_with_phone(number) do
    Repo.get_by(User, phone: number)
  end

  @spec phone_number_changeset(params :: map) :: Ecto.Changeset.t
  def phone_number_changeset(params \\ %{}) do
    Phone.changeset(%Phone{}, params)
  end

  @spec send_verification(params :: map) ::
  {:ok, String.t} | {:error, Ecto.Changeset.t}
  def send_verification(params) do
    with %{valid?: true} = changeset <- phone_number_changeset(params),
         number = Phone.number(changeset),
         {:ok, _} <- SmsVerification.send(number)
    do
      {:ok, number}
    else
      %{valid?: false} = changeset ->
        {:error, changeset}
      error ->
        Logger.error("Error when sending SMS verification: #{inspect error}")
        {:error, error}
    end
  end

  @spec verification_changeset(params :: map) :: Ecto.Changeset.t
  def verification_changeset(params \\ %{}) do
    Verification.changeset(%Verification{}, params)
  end

  @spec verify_phone(params :: map) ::
  {:ok, String.t} | {:error, Ecto.Changeset.t} | {:not_found, Ecto.Changeset.t}
  def verify_phone(params) do
    changeset = verification_changeset(params)
    with %{valid?: true} <- changeset,
         number = Verification.phone_number(changeset),
         %User{} = user <- get_user_with_phone(number) do
      {:ok, user}
    else
      nil -> {:not_found, changeset}
      _ -> {:error, changeset}
    end
  end
end
