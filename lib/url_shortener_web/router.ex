defmodule UrlShortenerWeb.Router do
  use UrlShortenerWeb, :router

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

  scope "/api", UrlShortenerWeb do
    pipe_through :api
    resources "/", UrlController, only: [:create]
  end

  scope "/", UrlShortenerWeb do
    pipe_through :browser

    get("/:id", UrlController, :get_and_redirect)
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", UrlShortenerWeb do
  #   pipe_through :api
  # end
end
