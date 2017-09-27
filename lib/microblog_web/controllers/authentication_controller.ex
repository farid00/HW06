defmodule MicroblogWeb.AuthenticationController do
  use MicroblogWeb, :controller

  alias Microblog.Account
  alias Microblog.Account.User
  alias Microblog.Account.Authentication


  def index(conn, _params) do
    changeset = Account.change_authentication(%Authentication{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"authentication" => auth_params}) do
    user = Account.login_user(%{"username" => auth_params["username"]})
    conn
    |> put_session(:user_id, user.id)
    |> redirect(to: user_path(conn, :show, user))
  end
end
