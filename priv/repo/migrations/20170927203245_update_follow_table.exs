defmodule Microblog.Repo.Migrations.UpdateFollowTable do
  use Ecto.Migration

  def change do
  	alter table(:follows) do
  		remove :follower_id
  		add :following_id, references(:users, on_delete: :nothing)
  	end


  end
end
