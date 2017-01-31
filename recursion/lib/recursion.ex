defmodule Recursion do
  @moduledoc """
  Examples of Recursion
  """

  @doc """
  Function to determine if an integer is even
  Uses body style recursion
  Also uses an example of a guard
  """

  @spec even?(integer) :: boolean
  def even?(0), do: true
  def even?(x) when x > 0, do: !even?(x - 1)
  def even?(x), do: !even?(x + 1)

  @doc """
  Convert time description as keyword list to seconds
  Supports keys of weeks, day, hours, minutes, and seconds
  Uses tail call style recursion
  This is a very typical pattern for processing through lists
  """

  @spec time_description_to_seconds([{:seconds | :minutes | :hours | :days | :weeks, number}]) :: number
  def time_description_to_seconds(list) do
    time_description_to_seconds(list, 0)
  end

  defp time_description_to_seconds([], accumulator) do
    accumulator
  end

  defp time_description_to_seconds([{:weeks, weeks} | tail], accumulator) do
    seconds = weeks * 7 * 24 * 60 * 60
    time_description_to_seconds(tail, accumulator + seconds)
  end

  defp time_description_to_seconds([{:days, days} | tail], accumulator) do
    seconds = days * 24 * 60 * 60
    time_description_to_seconds(tail, accumulator + seconds)
  end

  defp time_description_to_seconds([{:hours, hours} | tail], accumulator) do
    seconds = hours * 60 * 60
    time_description_to_seconds(tail, accumulator + seconds)
  end

  defp time_description_to_seconds([{:minutes, minutes} | tail], accumulator) do
    seconds = minutes * 60
    time_description_to_seconds(tail, accumulator + seconds)
  end

  defp time_description_to_seconds([{:seconds, seconds} | tail], accumulator) do
    time_description_to_seconds(tail, accumulator + seconds)
  end

  @doc """
  Calculates the output based on RPN rules
  More advanced recursion example using tail call style
  """

  @spec rpn_calculator(String.t) :: String.t
  def rpn_calculator(input) do
    rpn_calculator(String.split(input, " "), [])
  end

  defp rpn_calculator([], output) do
    Enum.reverse(output) |> Enum.join(" ")
  end

  defp rpn_calculator(["+" | itail], [a | [b | otail]]) do
    rpn_calculator(itail, [b + a | otail])
  end

  defp rpn_calculator(["-" | itail], [a | [b | otail]]) do
    rpn_calculator(itail, [b - a | otail])
  end

  defp rpn_calculator(["*" | itail], [a | [b | otail]]) do
    rpn_calculator(itail, [b * a | otail])
  end

  defp rpn_calculator(["/" | itail], [a | [b | otail]]) do
    rpn_calculator(itail, [b / a | otail])
  end

  defp rpn_calculator([val | tail], output) do
    rpn_calculator(tail, [String.to_integer(val) | output])
  end
end
