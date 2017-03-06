defmodule Otp.Job.Genserver do
  use GenServer

  # Client API

  def start_link do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def list do
    GenServer.call(__MODULE__, :list)
  end

  def info(job) do
    GenServer.call(__MODULE__, {:info, job})
  end

  def create(%{text: _} = params) do
    GenServer.cast(__MODULE__, {:create, params})
  end

  def destroy(job) do
    GenServer.cast(__MODULE__, {:destroy, job})
  end

  # Genserver callbacks

  def handle_call(:list, _from, state) do
    list = Map.keys(state)
    {:reply, list, state}
  end

  def handle_call({:info, job}, _from, state) do
    info = if Map.has_key?(state, job) do
      state[job]
      |> Map.delete(:pids)
    else
      :not_found
    end
    {:reply, info, state}
  end

  def handle_cast({:create, %{text: text} = params}, state) do
    job = System.unique_integer([:positive, :monotonic])
    workers = Map.get(params, :workers, 3)
    interval = Map.get(params, :interval, 3)
    pids = 1..workers
    |> Enum.map(&Supervisor.start_child(Otp.Worker.Supervisor, [&1, text, interval]))
    |> Enum.map(&elem(&1, 1))
    new_state = Map.put(state, job, %{text: text, workers: workers, interval: interval, pids: pids})
    {:noreply, new_state}
  end

  def handle_cast({:destroy, job}, state) do
    if Map.has_key?(state, job) do
      state[job].pids
      |> Enum.each(&GenServer.stop/1)
    end
    new_state = Map.delete(state, job)
    {:noreply, new_state}
  end
end
