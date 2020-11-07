defmodule RessipyWeb.Router do
  use RessipyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RessipyWeb do
    pipe_through :api

    get "/health", HealthController, :index
  end

  scope "/", RessipyWeb do
    pipe_through :browser

    get "/", CategoryController, :index
    get "/login", AccountController, :index
    post "/login", AccountController, :login
    get "/logout", AccountController, :logout
    post "/verify", AccountController, :verify

    post "/categories", CategoryController, :create
    get "/categories/new", CategoryController, :new
    get "/categories/:slug", CategoryController, :show
    get "/categories/:slug/edit", CategoryController, :edit
    put "/categories/:slug", CategoryController, :update
    delete "/categories/:slug", CategoryController, :delete

    post "/recipes", RecipeController, :create
    get "/recipes/new", RecipeController, :new
    get "/recipes/:slug", RecipeController, :show
    get "/recipes/:slug/edit", RecipeController, :edit
    put "/recipes/:slug", RecipeController, :update
    delete "/recipes/:slug", RecipeController, :delete
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: RessipyWeb.Telemetry
    end
  end
end
