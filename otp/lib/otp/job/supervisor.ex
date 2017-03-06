defmodule Otp.Job.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [
      supervisor(Otp.Worker.Supervisor, []),
      worker(Otp.Job.Genserver, [])
    ]

    supervise(children, strategy: :one_for_all)
  end
end
