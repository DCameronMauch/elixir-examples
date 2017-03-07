defmodule Otp do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      supervisor(Otp.Job.Supervisor, []),
      worker(Otp.Agent, [])
    ]

    opts = [strategy: :one_for_one, name: Otp.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
