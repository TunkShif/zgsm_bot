defmodule ZgsmBot.Handler.AtHandler do
  @behaviour ZgsmBot.Handler

  @impl true
  def handle_message(%{"message_type" => "group", "group_id" => group_id, "message" => message}) do
    if String.contains?(message, "[CQ:at,qq=1619162044]") ||
         String.contains?(message, "[CQ:at,qq=1956142937]") do
      ZgsmBot.send_message(:group, to: group_id, message: "780 zgsmn")
    end

    :ok
  end
end
