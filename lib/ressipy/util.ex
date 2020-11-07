defmodule Ressipy.Util do
  @moduledoc """
  Simple pure functions meant for use across multiple domains and layers.

  If it can't be fully tested with doctests, it doesn't belong here.
  """

  @doc """
  Create a slug from a proper string.

      iex> slugify("Dennis Beatty")
      "dennis-beatty"

      iex> slugify("Green Eggs & Ham")
      "green-eggs-ham"
  """
  @spec slugify(String.t()) :: String.t()
  def slugify(name) do
    name
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end
