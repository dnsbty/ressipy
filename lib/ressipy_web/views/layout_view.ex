defmodule RessipyWeb.LayoutView do
  use RessipyWeb, :view

  def og_title(%{title: title}), do: "#{title}"
  def og_title(_), do: "Ressipy"

  def title(%{title: title}), do: "#{title} | Ressipy"
  def title(_), do: "Ressipy"
end
