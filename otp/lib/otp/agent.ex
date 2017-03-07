defmodule Otp.Agent do
  def start_link do
    Agent.start_link(fn -> Map.new end, name: __MODULE__)
  end

  def add(key, value) do
    Agent.update(__MODULE__, fn state -> Map.put(state, key, value) end)
  end

  def get(key) do
    Agent.get(__MODULE__, fn state -> Map.get(state, key) end)
  end

  def list do
    Agent.get(__MODULE__, fn state -> Map.keys(state) end)
  end

  def delete(key) do
    Agent.update(__MODULE__, fn state -> Map.delete(state, key) end)
  end
end
