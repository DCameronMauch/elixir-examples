defmodule SupervisorTest.Worker do
  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args)
  end

  def state(pid) do
    GenServer.call(pid, :state)
  end

  def stop(pid) do
    GenServer.stop(pid, :normal)
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end
end
