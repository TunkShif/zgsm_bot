defmodule ZgsmBot.Handler do
  @callback handle_message(message :: any()) :: :ok
end
