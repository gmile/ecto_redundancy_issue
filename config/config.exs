use Mix.Config

config :logger, level: :debug

config :ecto_redundancy_issue, ecto_repos: [RedundancyRepo]

config :ecto_redundancy_issue, RedundancyRepo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "ecto_redundancy_issue",
  pool_size: 10
