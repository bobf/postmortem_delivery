defmodule PostmortemDeliveryWeb.Router do
  use PostmortemDeliveryWeb, :router
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

  scope "/", PostmortemDeliveryWeb do
    pipe_through :api
    resources "/emails", EmailController, only: [:create], param: "uri"
  end

  scope "/", PostmortemDeliveryWeb do
    pipe_through :browser
    resources "/", EmailController, only: [:show], param: "uri"
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router
    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PostmortemDeliveryWeb.Telemetry
    end
  end
end
