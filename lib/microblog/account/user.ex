defmodule Microblog.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Account.User


  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :nickname, :string
    field :username, :string
    many_to_many :following, User, join_through: Microblog.Account.Follow, join_keys: [user_id: :id, following_id: :id]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :first_name, :last_name, :nickname])
    |> validate_required([:username, :first_name, :last_name, :nickname])
  end
end
