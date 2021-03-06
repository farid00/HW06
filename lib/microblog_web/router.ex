defmodule MicroblogWeb.Router do
  use MicroblogWeb, :router
  import MicroblogWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_user
  end

  scope "/", MicroblogWeb do
    pipe_through :browser # Use the default browser stack
    delete "/login", AuthenticationController, :logout
    get "/login", AuthenticationController, :index
    post "/login", AuthenticationController, :create 
    resources "/likes", LikeController, except: [:new, :edit]
    resources "/follows", FollowController, except: [:index, :show]
    resources "/users", UserController
    resources "/posts", DisplayPostController
    get "/", AuthenticationController, :index
  end

  scope "/api", MicroblogWeb do
    pipe_through :api
    resources "/posts", PostController, except: [:new, :edit]
  end
end
