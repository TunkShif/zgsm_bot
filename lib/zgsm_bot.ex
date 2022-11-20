defmodule ZgsmBot do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {ZgsmBot.Websocket, ["init"]}
    ]

    opts = [strategy: :one_for_one, name: ZgsmBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
