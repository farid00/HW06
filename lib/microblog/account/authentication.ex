defmodule Microblog.Account.Authentication do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Account.Authentication


  schema "authentication" do
    field :username, :string


    timestamps()
  end

  @doc false
  def changeset(%Authentication{} = user, attrs) do
    user
    |> cast(attrs, [:username])
    |> validate_required([:username])
  end
end
