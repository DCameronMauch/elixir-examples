defmodule With do
  @moduledoc """
  Examples of using the with form
  """

  @compile if Mix.env == :test, do: :export_all

  @doc """
  Example to parse list of string data into dates and values
  """

  @spec process([String.t]) :: [{DateTime.t, float}] | {:error, String.t}
  def process(data) do
    with \
      indexed_data = index(data),
      parts when is_list(parts) <- split(indexed_data),
      epochs when is_list(epochs) <- epochs(parts),
      values when is_list(values) <- values(parts),
      combined = List.zip([epochs, values])
    do
      combined
    else
      {:not_slittable, number} -> {:error, "not splittable on line #{number}"}
      {:not_datetime, number} -> {:error, "invalid datetime on line #{number}"}
      {:not_value, number} -> {:error, "invalid value on line #{number}"}
    end
  end

  defp index([]), do: []
  defp index(data) do
    count = Enum.count(data)
    indexes = Range.new(1, count) |> Enum.to_list
    List.zip([indexes, data])
  end

  defp split(indexed_data), do: split(indexed_data, [])
  defp split([], accumulator), do: accumulator
  defp split([{number, text} | tail], accumulator) do
    result = String.split(text, "|") |> Enum.map(&String.trim/1)
    case result do
      [left, right] -> split(tail, accumulator ++ [{number, left, right}])
      _ -> {:not_slittable, number}
    end
  end

  def epochs(parts), do: epochs(parts, [])
  def epochs([], accumulator), do: accumulator
  def epochs([{number, text, _} | tail], accumulator) do
    result = DateTime.from_iso8601(text)
    case result do
      {:ok, datetime, 0} ->
        epoch = DateTime.to_unix(datetime)
        epochs(tail, accumulator ++ [epoch])
      _ -> {:not_datetime, number}
    end
  end

  def values(parts), do: values(parts, [])
  def values([], accumulator), do: accumulator
  def values([{number, _, text} | tail], accumulator) do
    result = Float.parse(text)
    case result do
      {value, ""} -> values(tail, accumulator ++ [value])
      _ -> {:not_value, number}
    end
  end
end
