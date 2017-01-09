defmodule RecursionExamples do
  def time_description_to_seconds(list) do
    time_description_to_seconds(list, 0)
  end

  defp time_description_to_seconds([], accumulator) do
    accumulator
  end

  defp time_description_to_seconds([{:weeks, value} | tail], accumulator) do
    seconds = value * 7 * 24 * 60 * 60
    time_description_to_seconds(tail, accumulator + seconds)
  end

  defp time_description_to_seconds([{:days, value} | tail], accumulator) do
    seconds = value * 24 * 60 * 60
    time_description_to_seconds(tail, accumulator + seconds)
  end

  defp time_description_to_seconds([{:hours, value} | tail], accumulator) do
    seconds = value * 60 * 60
    time_description_to_seconds(tail, accumulator + seconds)
  end

  defp time_description_to_seconds([{:minutes, value} | tail], accumulator) do
    seconds = value * 60
    time_description_to_seconds(tail, accumulator + seconds)
  end

  defp time_description_to_seconds([{:seconds, value} | tail], accumulator) do
    time_description_to_seconds(tail, accumulator + value)
  end
end
