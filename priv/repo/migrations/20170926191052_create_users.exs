defmodule Microblog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :first_name, :string
      add :last_name, :string
      add :nickname, :string

      timestamps()
    end

  end
end
