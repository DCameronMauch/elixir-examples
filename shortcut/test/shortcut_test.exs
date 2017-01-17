defmodule ShortcutTest do
  use ExUnit.Case

  test "generate/1" do
    length = :rand.uniform(99)
    output = Shortcut.generate(length)
    assert is_binary(output)
    assert String.length(output) == length
  end
end
