defmodule RessipyWeb.RecipeView do
  use RessipyWeb, :view

  def for_select(categories) do
    Enum.map(categories, &{&1.name, &1.id})
  end
end
