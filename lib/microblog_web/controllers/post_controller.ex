defmodule MicroblogWeb.PostController do
  use MicroblogWeb, :controller

  alias Microblog.Messages
  alias Microblog.Messages.Post
  alias MicroblogWeb.UpdatesChannel
  action_fallback MicroblogWeb.FallbackController

  def index(conn, _params) do

    posts = 
      case conn.assigns.current_user do
        nil -> Messages.list_posts()
        _ -> Messages.list_posts(conn.assigns.current_user_id)
      end
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    if conn.assigns.current_user do
      post_params = Map.put(post_params, "user_id", conn.assigns.current_user_id)
      with {:ok, %Post{} = post} <- Messages.create_post(post_params) do
        UpdatesChannel.broadcast_post(conn, post)

        conn
        |> put_status(:created)
        |> put_resp_header("location", post_path(conn, :show, post))
        |> render("show.json", post: post)
      end
    else
      send_resp(conn, :no_content, "")
    end
  end

  def show(conn, %{"id" => id}) do
    post = Messages.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Messages.get_post!(id)

    with {:ok, %Post{} = post} <- Messages.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Messages.get_post!(id)
    with {:ok, %Post{}} <- Messages.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
