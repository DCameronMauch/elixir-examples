defmodule Server2.Worker do
  @moduledoc false

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def ping do
    GenServer.multi_call(__MODULE__, :ping)
  end

  def handle_call(:ping, _from, state) do
    {:reply, "pong from server2", state}
  end
end
