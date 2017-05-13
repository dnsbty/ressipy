defmodule Ressipy.Web.RecipeView do
  use Ressipy.Web, :view

  def for_select(categories) do
     Enum.map(categories, &{&1.name, &1.id})
  end
end
