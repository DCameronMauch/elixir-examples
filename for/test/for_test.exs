defmodule ForTest do
  use ExUnit.Case

  test "add_one/1" do
    assert For.add_one([1, 2, 3, 4, 5]) == [2, 3, 4, 5, 6]
  end

  test "mix_two/2" do
    assert For.mix_two([:a, :b], [1, 2]) == [a: 1, a: 2, b: 1, b: 2]
  end

  test "mix_even/2" do
    assert For.mix_even([:a, :b], [1, 2, 3, 4]) == [a: 2, a: 4, b: 2, b: 4]
  end

  test "add_one_into_string/1" do
    list = [71, 100, 107, 107, 110, 86, 110, 113, 107, 99]
    assert For.add_one_into_string(list) == "HelloWorld"
  end
end
