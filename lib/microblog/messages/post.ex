defmodule Microblog.Messages.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Messages.Post
  alias Microblog.Account.User


  schema "posts" do
    field :text, :string
    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:text, :user_id])
    |> validate_required([:text])
  end
end
