defmodule ZgsmBot.Websocket do
  use WebSockex

  @endpoint "ws://localhost:6958"

  def start_link(state, opts \\ []) do
    WebSockex.start_link(@endpoint, __MODULE__, state, opts)
  end

  def handle_frame({:text, msg}, state) do
    send(self(), Jason.decode!(msg))
    {:ok, state}
  end

  def handle_info(%{"post_type" => "message", "message_type" => "private"} = msg, state) do
    res = %{
      action: "send_private_msg",
      params: %{
        user_id: msg["user_id"],
        message: "zgsm"
      }
    }

    {:reply, {:text, Jason.encode!(res)}, state}
  end

  def handle_info(%{"post_type" => "message", "message_type" => "group"} = msg, state) do
    IO.inspect(msg)

    res = %{
      action: "send_group_msg",
      params: %{
        group_id: msg["group_id"],
        message: "zgsm"
      }
    }

    {:reply, {:text, Jason.encode!(res)}, state}
  end

  def handle_info(_msg, state) do
    {:ok, state}
  end
end
