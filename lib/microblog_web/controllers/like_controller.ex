defmodule MicroblogWeb.LikeController do
  use MicroblogWeb, :controller

  alias Microblog.Feedback
  alias Microblog.Feedback.Like

  def index(conn, %{"post_id" => p_id}) do
    likes = Feedback.get_likes_by_post(p_id)
    render(conn, "index.json", likes: likes)
  end

  def create(conn, %{"like" => like_params}) do
    with {:ok, %Like{} = like} <- Feedback.create_like(Map.put(like_params, "user_id", conn.assigns.current_user_id)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", like_path(conn, :show, like))
      |> render("show.json", like: like)
    end
  end

  def show(conn, %{"id" => id}) do
    like = Feedback.get_like!(id)
    render(conn, "show.json", like: like)
  end

  def update(conn, %{"id" => id, "like" => like_params}) do
    like = Feedback.get_like!(id)

    with {:ok, %Like{} = like} <- Feedback.update_like(like, like_params) do
      render(conn, "show.json", like: like)
    end
  end

  def delete(conn, %{"id" => id}) do
    like = Feedback.get_like!(id)
    with {:ok, %Like{}} <- Feedback.delete_like(like) do
      send_resp(conn, :no_content, "")
    end
  end
end
