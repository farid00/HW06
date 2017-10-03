defmodule MicroblogWeb.AuthenticationController do
  use MicroblogWeb, :controller

  alias Microblog.Account
  alias Microblog.Account.Authentication


  def index(conn, _params) do
    changeset = Account.change_authentication(%Authentication{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"authentication" => auth_params}) do
    user = Account.login_user(%{"username" => auth_params["username"]})
    
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Logged in as #{user.username}")
      |> redirect(to: user_path(conn, :show, user))
    else
      conn
      |> put_flash(:error, "No user could be found with that username, try again")
      |> redirect(to: authentication_path(conn, :index))
    end 
  end

  def logout(conn, _params) do
    conn
    |> put_session(:user_id, nil)
    |> assign(:current_user, nil)
    |> put_flash(:info, "You have logged out")
    |> redirect(to: post_path(conn, :index))
  end
end
