defmodule Microblog.Account.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Account.User


  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :nickname, :string
    field :username, :string
    field :password_hash, :string


    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    many_to_many :following, User, join_through: Microblog.Account.Follow, join_keys: [user_id: :id, following_id: :id]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :first_name, :last_name, :nickname, :password, :password_confirmation])
    |> validate_confirmation(:password)
    |> validate_password(:password)
    |> put_pass_hash()
    |> validate_required([:username, :first_name, :last_name, :nickname, :password_hash])
  end

  # Password validation
  # From Comeonin docs
  def validate_password(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, password ->
      case valid_password?(password) do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || msg}]
      end
    end)
  end

  def put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash(password))
  end
  def put_pass_hash(changeset), do: changeset


  def valid_password?(password) when byte_size(password) > 7 do
    {:ok, password}
  end
  def valid_password?(_), do: {:error, "The password is too short"}
end
