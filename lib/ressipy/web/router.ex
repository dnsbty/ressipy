defmodule Ressipy.Web.Router do
  use Ressipy.Web, :router

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

  pipeline :auth do
    plug Ressipy.Web.Plugs.Auth, ["admin"]
  end

  scope "/", Ressipy.Web do
    pipe_through :browser # Use the default browser stack

    get "/", CategoryController, :index
    resources "/categories", CategoryController
    resources "/ingredients", IngredientController
    resources "/recipes", RecipeController
    resources "/instructions", InstructionController
    resources "/roles", RoleController
    resources "/users", UserController
  end

  scope "/auth", Ressipy.Web do
    pipe_through :browser

    get "/facebook", AuthController, :request
    get "/facebook/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", Ressipy.Web do
  #   pipe_through :api
  # end
end
