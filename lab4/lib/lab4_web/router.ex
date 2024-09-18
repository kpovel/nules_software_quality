defmodule Lab4Web.Router do
  use Lab4Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/books", Lab4Web do
    pipe_through :api

    get "/", BookController, :index
    get "/:id", BookController, :show
    post "/", BookController, :create
    put "/:id", BookController, :update
    delete "/:id", BookController, :delete
  end

  scope "/api/users", Lab4Web do
    pipe_through :api

    get "/", UserController, :index
    get "/:id", UserController, :show
    post "/", UserController, :create
    put "/:id", UserController, :update
    delete "/:id", UserController, :delete
  end

  scope "/api/orders", Lab4Web do
    pipe_through :api

    get "/", OrderController, :index
    get "/:id", OrderController, :show
    get "/user/:user_id", OrderController, :user_orders

    post "/", OrderController, :create
    put "/:id", OrderController, :update
  end

  if Application.compile_env(:lab4, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: Lab4Web.Telemetry
    end
  end
end
