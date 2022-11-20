defmodule ZgsmBot do
  use WebSockex

  @handlers [
    ZgsmBot.Handler.CmdHandler,
    ZgsmBot.Handler.AtHandler
  ]

  def start_link(state, opts \\ []) do
    WebSockex.start_link(endpoint(), __MODULE__, state, opts)
  end

  defp endpoint, do: Application.fetch_env!(:zgsm_bot, :endpoint)

  def send_message(:private, to: to, message: message)
      when is_number(to) and is_binary(message) do
    params = %{
      user_id: to,
      message: message
    }

    WebSockex.cast(self(), {:request, {"send_private_msg", params}})
  end

  def send_message(:group, to: to, message: message)
      when is_number(to) and is_binary(message) do
    params = %{
      group_id: to,
      message: message
    }

    WebSockex.cast(self(), {:request, {"send_group_msg", params}})
  end

  def handle_frame({:text, msg}, state) do
    send(self(), Jason.decode!(msg))
    {:ok, state}
  end

  def handle_cast({:request, {action, params}}, state) do
    {:reply, {:text, Jason.encode!(%{action: action, params: params})}, state}
  end

  def handle_info(%{"post_type" => "message"} = msg, state) do
    Enum.each(@handlers, &apply(&1, :handle_message, [msg]))
    {:ok, state}
  end

  def handle_info(msg, state) do
    if msg["post_type"] == "message" do
      IO.inspect(msg)
    end

    {:ok, state}
  end
end
