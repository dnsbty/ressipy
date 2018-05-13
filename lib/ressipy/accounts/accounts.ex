defmodule Ressipy.Accounts do
  alias Ressipy.Accounts.User
  alias Ressipy.Repo

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
end
