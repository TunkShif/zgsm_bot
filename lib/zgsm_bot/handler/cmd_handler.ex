defmodule ZgsmBot.Handler.CmdHandler do
  @behaviour ZgsmBot.Handler

  @impl true
  def handle_message(%{"message_type" => "group", "group_id" => group_id, "message" => message}) do
    if String.starts_with?(message, "/zgsm") do
      message =
        try do
          dbg(["/zgsm", cmd | params] = String.split(message))
          get_cmd(cmd, params)
        rescue
          _ -> get_cmd("help", [])
        end

      ZgsmBot.send_message(:group, to: group_id, message: message)
    end
  end

  defp get_cmd("help", _) do
    "你说得对，但是 zgsm 是由 zgsm 自主研发的一款全新的智能关怀系统。系统将发生在一个叫做 Big Bear 的幻想世界，在这里，被 zgsm 选中的人将被问候以 zgsm，接受群友亲切的问候。你将扮演一名 zgsm 的神秘角色，在自由的旅行中邂逅各种性格迥异、XP 独特的群友们，和他们一起转发 zgsm，找回失散的亲情——同时逐步发掘“zgsm”的真相。"
  end
end
