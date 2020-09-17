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
    resources "/categories", CategoryController
    resources "/ingredients", IngredientController
    resources "/recipes", RecipeController
    resources "/instructions", InstructionController
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: RessipyWeb.Telemetry
    end
  end
end
