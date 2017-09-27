defmodule Microblog.Account.Follow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Account.Follow


  schema "follows" do
    belongs_to :user, User
    belongs_to :following, :id

    timestamps()
  end

  @doc false
  def changeset(%Follow{} = follow, attrs) do
    follow
    |> cast(attrs, [:user_id, :following_id])
    |> validate_required([])
  end
end
