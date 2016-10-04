defmodule SimpleSpawn do
  def square(obj) do
    [obj]
    |> List.flatten
    |> Enum.map(fn number ->
      spawn(SimpleSpawn, :square, [])
      |> send({self, number})
    end)
    |> Enum.map(fn _ ->
      receive do
        number -> number
      end
    end)
  end

  def square do
    receive do
      {pid, number} -> send(pid, number * number)
      _ -> false
    end
  end
end
