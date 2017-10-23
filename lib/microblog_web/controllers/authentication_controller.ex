defmodule MicroblogWeb.AuthenticationController do
  use MicroblogWeb, :controller

  alias Microblog.Account
  alias Microblog.Repo
  alias Microblog.Account.Authentication
  alias Microblog.Account.User


  def index(conn, _params) do
    changeset = Account.change_authentication(%Authentication{})
    render(conn, "new.html", changeset: changeset)
  end

  def get_and_auth_user(username, password) do
    IO.puts username
    user = Repo.get_by(User, username: username)
    case Comeonin.Argon2.check_pass(user, password) do
      {:ok, user} -> user
      _else       -> nil
    end
  end

  def create(conn, %{"authentication" => auth_params}) do
    if auth_params["username"] do
      if auth_params["password"] do
        user = get_and_auth_user(auth_params["username"], auth_params["password"])
      else
        user = nil
      end
    else
      user = nil
    end 
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Logged in as #{user.username}")
      |> redirect(to: display_post_path(conn, :index))
    else
      conn
      |> put_flash(:error, "No user could be found with that username and password, try again")
      |> redirect(to: authentication_path(conn, :index))
    end 
  end

  def logout(conn, _params) do
    conn
    |> put_session(:user_id, nil)
    |> assign(:current_user, nil)
    |> put_flash(:info, "You have logged out")
    |> redirect(to: display_post_path(conn, :index))
  end
end
