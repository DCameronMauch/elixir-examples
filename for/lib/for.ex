defmodule For do
  @moduledoc """
  Examples of For Comprehensions
  """

  @doc """
  single generator
  """
  @spec add_one([integer]) :: [integer]
  def add_one(list) do
    for x <- list, do: x + 1
  end

  @doc """
  double generator
  """
  @spec mix_two([atom], [integer]) :: [{atom, integer}]
  def mix_two(list1, list2) do
    for \
      a <- list1,
      b <- list2
    do
      {a, b}
    end
  end

  @doc """
  double generator, single filter
  """
  @spec mix_even([atom], [integer]) :: [{atom, integer}]
  def mix_even(list1, list2) do
    for \
      a <- list1,
      b <- list2,
      rem(b, 2) == 0
    do
      {a, b}
    end
  end

  @doc """
  single generator, into string
  """
  @spec add_one_into_string([integer]) :: String.t
  def add_one_into_string(list) do
    for x <- list, into: "", do: <<x + 1>>
  end
end
