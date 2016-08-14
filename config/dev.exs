use Mix.Config


config :auth, Auth.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "dev",
  password: "dev",
  database: "auth",
  hostname: "localhost",
  pool_size: 10
