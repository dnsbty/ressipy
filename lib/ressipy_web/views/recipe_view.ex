defmodule RessipyWeb.RecipeView do
  use RessipyWeb, :view

  @spec has_id?(Phoenix.HTML.Form.t()) :: boolean()
  def has_id?(form) do
    !!form.data.id
  end

  def for_select(categories) do
    Enum.map(categories, &{&1.name, &1.id})
  end
end
