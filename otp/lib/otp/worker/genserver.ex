defmodule Otp.Worker.Genserver do
  use GenServer

  # Client API

  def start_link(worker, text, interval) do
    GenServer.start_link(__MODULE__, {worker, text, interval})
  end

  # Genserver callbacks

  def init(state) do
    send(self(), :work)
    {:ok, state}
  end

  def handle_info(:work, {worker, text, interval} = state) do
    Process.send_after(self(), :work, interval * 1_000)
    IO.puts("#{text} from worker #{worker}")
    {:noreply, state}
  end

  def terminate(_reason, {worker, _text, _interval}) do
    IO.puts("worker #{worker} terminating")
  end
end
