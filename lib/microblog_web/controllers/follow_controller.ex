defmodule MicroblogWeb.FollowController do
  use MicroblogWeb, :controller

  alias Microblog.Account
  alias Microblog.Account.Follow

  def index(conn, _params) do
    follows = Account.list_follows()
    render(conn, "index.html", follows: follows)
  end

  def new(conn, _params) do
    changeset = Account.change_follow(%Follow{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"follow" => follow_params}) do
    user_id = get_session(conn, :user_id)
    follow_params = Map.put(follow_params, "user_id", user_id)
    case Account.create_follow(follow_params) do
      {:ok, follow} ->
        conn
        |> put_flash(:info, "Follow created successfully.")
        |> redirect(to: follow_path(conn, :show, follow))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    follow = Account.get_follow!(id)
    render(conn, "show.html", follow: follow)
  end

  def edit(conn, %{"id" => id}) do
    follow = Account.get_follow!(id)
    changeset = Account.change_follow(follow)
    render(conn, "edit.html", follow: follow, changeset: changeset)
  end

  def update(conn, %{"id" => id, "follow" => follow_params}) do
    follow = Account.get_follow!(id)

    case Account.update_follow(follow, follow_params) do
      {:ok, follow} ->
        conn
        |> put_flash(:info, "Follow updated successfully.")
        |> redirect(to: follow_path(conn, :show, follow))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", follow: follow, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    follow = Account.get_follow!(id)
    {:ok, _follow} = Account.delete_follow(follow)

    conn
    |> put_flash(:info, "Follow deleted successfully.")
    |> redirect(to: follow_path(conn, :index))
  end
end
