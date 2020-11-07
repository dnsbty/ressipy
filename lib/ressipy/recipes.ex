defmodule Ressipy.Recipes do
  @moduledoc """
  The boundary for the Recipes system.
  """

  import Ecto.{Query, Changeset}, warn: false
  alias Ressipy.Repo

  alias Ressipy.Recipes.{
    Category,
    Ingredient,
    Instruction,
    Recipe,
    RecipeIngredient
  }

  @doc """
  Returns the list of categories.

  ## Examples

      iex> list_categories()
      [%Category{}, ...]

  """
  def list_categories do
    Repo.all(from(c in Category, order_by: c.name))
  end

  @doc """
  Gets a single category.

  Raises `Ecto.NoResultsError` if the Category does not exist.

  ## Examples

      iex> get_category!("main-dishes")
      %Category{}

      iex> get_category!("abcd")
      ** (Ecto.NoResultsError)

  """
  def get_category!(slug) do
    query =
      from(c in Category,
        left_join: r in assoc(c, :recipes),
        preload: [recipes: r],
        order_by: r.name
      )

    Repo.get_by!(query, slug: slug)
  end

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Category{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a category.

  ## Examples

      iex> update_category(category, %{field: new_value})
      {:ok, %Category{}}

      iex> update_category(category, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Category.

  ## Examples

      iex> delete_category(category)
      {:ok, %Category{}}

      iex> delete_category(category)
      {:error, %Ecto.Changeset{}}

  """
  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking category changes.

  ## Examples

      iex> change_category(category)
      %Ecto.Changeset{source: %Category{}}

  """
  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  @doc """
  Returns the list of ingredients.

  ## Examples

      iex> list_ingredients()
      [%Ingredient{}, ...]

  """
  def list_ingredients do
    Repo.all(Ingredient)
  end

  @doc """
  Gets a single ingredient.

  Raises `Ecto.NoResultsError` if the Ingredient does not exist.

  ## Examples

      iex> get_ingredient!(123)
      %Ingredient{}

      iex> get_ingredient!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ingredient!(id), do: Repo.get!(Ingredient, id)

  @doc """
  Creates a ingredient.

  ## Examples

      iex> create_ingredient(%{field: value})
      {:ok, %Ingredient{}}

      iex> create_ingredient(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ingredient(attrs \\ %{}) do
    %Ingredient{}
    |> Ingredient.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ingredient.

  ## Examples

      iex> update_ingredient(ingredient, %{field: new_value})
      {:ok, %Ingredient{}}

      iex> update_ingredient(ingredient, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ingredient(%Ingredient{} = ingredient, attrs) do
    ingredient
    |> Ingredient.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ingredient.

  ## Examples

      iex> delete_ingredient(ingredient)
      {:ok, %Ingredient{}}

      iex> delete_ingredient(ingredient)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ingredient(%Ingredient{} = ingredient) do
    Repo.delete(ingredient)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ingredient changes.

  ## Examples

      iex> change_ingredient(ingredient)
      %Ecto.Changeset{source: %Ingredient{}}

  """
  def change_ingredient(%Ingredient{} = ingredient) do
    change_ingredient(ingredient, %{})
  end

  def change_ingredient(%Ingredient{} = ingredient, attrs) do
    Ingredient.changeset(ingredient, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe ingredient changes.

  ## Examples

      iex> change_ingredients(ingredient)
      %Ecto.Changeset{source: %Ingredient{}}

  """
  def change_recipe_ingredient(%RecipeIngredient{} = ingredient, attrs) do
    RecipeIngredient.changeset(ingredient, attrs)
  end

  @doc """
  Returns the list of recipes.

  ## Examples

      iex> list_recipes()
      [%Recipe{}, ...]

  """
  def list_recipes do
    Repo.all(
      from(r in Recipe,
        left_join: c in assoc(r, :category),
        preload: [category: c],
        order_by: r.name
      )
    )
  end

  @doc """
  Gets a single recipe.

  Raises `Ecto.NoResultsError` if the Recipe does not exist.

  ## Examples

      iex> get_recipe!("chicken-parmesan")
      %Recipe{}

      iex> get_recipe!("cake")
      ** (Ecto.NoResultsError)

  """
  def get_recipe!(slug) do
    query =
      from(r in Recipe,
        left_join: c in assoc(r, :category),
        left_join: s in assoc(r, :instructions),
        left_join: j in assoc(r, :ingredients),
        left_join: g in assoc(j, :ingredient),
        preload: [
          category: c,
          ingredients: {j, ingredient: g},
          instructions: s
        ],
        order_by: [j.order, s.order]
      )

    Repo.get_by!(query, slug: slug)
  end

  @doc """
  Creates a recipe.

  ## Examples

      iex> create_recipe(%{field: value})
      {:ok, %Recipe{}}

      iex> create_recipe(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_recipe(attrs \\ %{}) do
    %Recipe{}
    |> Recipe.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a recipe.

  ## Examples

      iex> update_recipe(recipe, %{field: new_value})
      {:ok, %Recipe{}}

      iex> update_recipe(recipe, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_recipe(%Recipe{} = recipe, attrs) do
    recipe
    |> Recipe.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Recipe.

  ## Examples

      iex> delete_recipe(recipe)
      {:ok, %Recipe{}}

      iex> delete_recipe(recipe)
      {:error, %Ecto.Changeset{}}

  """
  def delete_recipe(%Recipe{} = recipe) do
    Repo.delete(recipe)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking recipe changes.

  ## Examples

      iex> change_recipe(recipe)
      %Ecto.Changeset{source: %Recipe{}}

  """
  def change_recipe(%Recipe{} = recipe, attrs \\ %{}) do
    Recipe.changeset(recipe, attrs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` representing a brand new empty recipe.

  ## Examples

      iex> empty_recipe()
      %Ecto.Changeset{source: %Recipe{}}
  """
  @spec empty_recipe(Category.t() | nil) :: Ecto.Changeset.t()
  def empty_recipe(category \\ nil) do
    category_id = if category, do: category.id, else: nil

    recipe = %Recipe{
      category_id: category_id,
      ingredients: [
        %RecipeIngredient{
          order: 1,
          ingredient: %Ingredient{}
        }
      ],
      instructions: [%Instruction{order: 1}]
    }

    change_recipe(recipe)
  end

  @doc """
  Returns the list of instructions.

  ## Examples

      iex> list_instructions()
      [%Instruction{}, ...]

  """
  def list_instructions do
    Repo.all(Instruction)
  end

  @doc """
  Gets a single instruction.

  Raises `Ecto.NoResultsError` if the Instruction does not exist.

  ## Examples

      iex> get_instruction!(123)
      %Instruction{}

      iex> get_instruction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_instruction!(id), do: Repo.get!(Instruction, id)

  @doc """
  Creates a instruction.

  ## Examples

      iex> create_instruction(%{field: value})
      {:ok, %Instruction{}}

      iex> create_instruction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_instruction(attrs \\ %{}) do
    %Instruction{}
    |> Instruction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a instruction.

  ## Examples

      iex> update_instruction(instruction, %{field: new_value})
      {:ok, %Instruction{}}

      iex> update_instruction(instruction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_instruction(%Instruction{} = instruction, attrs) do
    instruction
    |> Instruction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Instruction.

  ## Examples

      iex> delete_instruction(instruction)
      {:ok, %Instruction{}}

      iex> delete_instruction(instruction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_instruction(%Instruction{} = instruction) do
    Repo.delete(instruction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking instruction changes.

  ## Examples

      iex> change_instruction(instruction)
      %Ecto.Changeset{source: %Instruction{}}

  """
  def change_instruction(%Instruction{} = instruction) do
    change_instruction(instruction, %{})
  end

  def change_instruction(%Instruction{} = instruction, attrs) do
    Instruction.changeset(instruction, attrs)
  end
end
