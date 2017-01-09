defmodule Sebastian.Router do
  use Sebastian.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :auth do
    plug Guardian.Plug.EnsureAuthenticated, handler: Unicorn.AuthHandler
    plug Sheriff.Plug.LoadResource, resource_loader: Unicorn.UserLoader
    plug Sheriff.Plug.EnforcePolicy, policy: Unicorn.UserPolicy
  end

  scope "/admin", Sebastian.Admin do
    pipe_through [:browser, :browser_session, :auth]

    get "/pages", PageController, :index
  end

  scope "/", Sebastian do
    pipe_through :browser

    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    get "/", PageController, :index
  end
end
