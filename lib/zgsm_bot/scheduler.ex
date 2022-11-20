defmodule ZgsmBot.Scheduler do
  use Quantum, otp_app: :zgsm_bot

  def send_zgsm() do
    ZgsmBot.send_message(:group, to: 541_602_915, message: "[CQ:at,qq=1619162044] zgsm")
  end
end
