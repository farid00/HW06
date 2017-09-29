defmodule MicroblogWeb.Plugs do
	import Plug.Conn
	alias Microblog.Account.User

	def get_user(user_id) do
		Microblog.Repo.get_by(User, id: user_id)
	end



	def fetch_user(conn, _opts) do
		user_id = get_session(conn, :user_id)
		if user_id do
			current_user = get_user(user_id)
			conn
			|> assign(:current_user, current_user)
		else
			conn
			|> assign(:current_user, nil)
		end
	end
end