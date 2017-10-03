# This module is inspired by the plugs file in 
# https://github.com/NatTuck/nu_mart/tree/master/lib/nu_mart_web
#
defmodule MicroblogWeb.Plugs do
	import Plug.Conn
	alias Microblog.Account.User
	require Logger

	def get_user(user_id) do
		Microblog.Repo.get_by(User, id: user_id)
		|> Microblog.Repo.preload(:following)
	end



	def fetch_user(conn, _opts) do
		user_id = get_session(conn, :user_id)
		if user_id do
			current_user = get_user(user_id)
			if current_user do
				conn
				|> assign(:current_user, current_user)
				|> assign(:logout_message, current_user.username <> " | Sign Out")
			else 
				conn
				|> assign(:current_user, nil)
			end
		else
			conn
			|> assign(:current_user, nil)
		end
	end
end