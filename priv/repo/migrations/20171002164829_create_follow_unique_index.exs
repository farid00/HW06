defmodule Microblog.Repo.Migrations.CreateFollowUniqueIndex do
  use Ecto.Migration

  def change do
  	create unique_index(:follows, [:user_id, :following_id])
  end
end
