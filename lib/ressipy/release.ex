defmodule Ressipy.Release do
  @moduledoc """
  Release tasks to be run manually or as externally controlled jobs.

  Typically these will be run through the release binary's eval or rpc
  commands:

  ```
  # Run the database migrations
  bin/ressipy eval Ressipy.Release.migrate() 

  # Roll back a migration
  bin/ressipy eval Ressipy.Release.rollback(Ressipy.Repo, 20201105040920) 
  ```
  """

  alias Ressipy.{Recipes, Repo, Util}
  alias Ressipy.Recipes.Recipe
  import Ecto.Query

  @app :ressipy

  @doc """
  Backfill slugs for categories so that they can be used in URLs instead of IDs.
  """
  @spec backfill_slugs :: :ok
  def backfill_slugs do
    for category <- Recipes.list_categories() do
      slug = Util.slugify(category.name)
      Recipes.update_category(category, %{slug: slug})
    end

    for recipe <- Recipes.list_recipes() do
      slug = Util.slugify(recipe.name)
      recipe_id = recipe.id

      query = from(r in Recipe, where: r.id == ^recipe_id)
      Repo.update_all(query, set: [slug: slug])
    end
  end

  @doc """
  Runs the database migrations.
  """
  @spec migrate :: no_return()
  def migrate do
    start_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  @doc """
  Rolls back the database migrations to the state prior to the provided version.
  """
  @spec rollback(module(), pos_integer()) :: no_return()
  def rollback(repo, version) do
    start_app()

    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  # PRIVATE

  @spec repos :: list(module())
  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  @spec start_app :: {:ok, [atom()]} | {:error, {atom(), term()}}
  defp start_app do
    Application.load(@app)
    Application.put_env(@app, :database_only, true)
    Application.ensure_all_started(@app)
  end
end
