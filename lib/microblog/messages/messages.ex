defmodule Microblog.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias Microblog.Repo

  alias Microblog.Messages.Post
  alias Microblog.Account.Follow
  alias Microblog.Feedback.Like

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    query = from p in Post,
              group_by: p.id,
              order_by: [desc: p.updated_at],
              left_join: l in Like, on: p.id == l.post_id

    query = from [p, l]  in query,
              select: %{p | likes: count(l.id) }
    Repo.all(query)
    |> Repo.preload(:user)
  end

  def list_posts(current_user_id) do
    IO.puts current_user_id
    query = from p in Post,
              group_by: p.id,
              order_by: [desc: p.updated_at],
              join: f in Follow, on: p.user_id == f.following_id and f.user_id == ^current_user_id,
              left_join: l in Like, on: p.id == l.post_id
    query = from [p, f, l]  in query,
              select: %{p | likes: count(l.id) }
    Repo.all(query)
    |> Repo.preload(:user)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end
end
