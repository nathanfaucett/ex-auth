use Mix.Config


config :auth, Auth.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "dev",
  password: "dev",
  database: "testdb_auth",
  hostname: "localhost",
  pool_size: 10
