defmodule AuthService do
  use Application


  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(AuthService.Repo, [])
    ]

    opts = [strategy: :one_for_one, name: AuthService.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
