use Mix.Config


config :auth_service, AuthService.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "dev",
  password: "dev",
  database: "auth_service",
  hostname: "localhost",
  pool_size: 10
