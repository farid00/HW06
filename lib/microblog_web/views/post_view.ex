defmodule MicroblogWeb.PostView do
  use MicroblogWeb, :view
  alias MicroblogWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    data = %{
      id: post.id,
      text: post.text,
      likes: post.likes
    }
    if Ecto.assoc_loaded?(post.user) and post.user != nil do
      Map.put(data, :username, post.user.username)
    else
      data
    end
  end
end
