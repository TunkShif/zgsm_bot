import Config

config :logger, level: :debug

config :zgsm_bot, endpoint: "ws://localhost:6958"

config :zgsm_bot, ZgsmBot.Scheduler, jobs: [{"*/60 * * * *", {ZgsmBot.Scheduler, :send_zgsm, []}}]
