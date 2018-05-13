defmodule Ressipy.Web.Router do
  use Ressipy.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", Ressipy.Web do
    pipe_through :browser # Use the default browser stack

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
end
