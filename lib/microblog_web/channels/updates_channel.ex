defmodule MicroblogWeb.UpdatesChannel do
  use MicroblogWeb, :channel

  def join("updates:all", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (updates:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def broadcast_post(conn, post) do
    IO.puts("hi")
    payload = %{id: post.id, text: post.text}
    if conn.assigns.current_user do
      payload = Map.put(payload, "username", conn.assigns.current_user.username)
    else
      payload = Map.put(payload, "username", nil)
    end
    MicroblogWeb.Endpoint.broadcast!("updates:all", "new_message", payload)
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
