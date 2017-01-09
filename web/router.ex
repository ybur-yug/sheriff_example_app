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

  pipeline :authentication do
    plug Guardian.Plug.EnsureAuthenticated, handler: Sebastian.AuthHandler
  end

  pipeline :authorization do
    plug Sheriff.Plug.EnforcePolicy, policy: Sebastian.UserPolicy
    plug Sheriff.Plug.LoadResource, resource_loader: Sebastian.UserLoader
  end

  scope "/admin", Sebastian.Admin do
    pipe_through [:browser, :browser_session, :authentication, :authorization]

    get "/pages", PageController, :index
  end

  scope "/", Sebastian do
    pipe_through :browser

    resources "/users", UserController, only: [:new, :create]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    get "/", PageController, :index
  end
end
