defmodule RecursionExamplesTest do
  use ExUnit.Case

  import RecursionExamples

  describe "time_description_to_seconds" do
    test "weeks" do
      assert time_description_to_seconds(weeks: 3) == 1_814_400
    end

    test "days" do
      assert time_description_to_seconds(days: 3) == 259_200
    end

    test "hours" do
      assert time_description_to_seconds(hours: 3) == 10_800
    end

    test "minutes" do
      assert time_description_to_seconds(minutes: 3) == 180
    end

    test "seconds" do
      assert time_description_to_seconds(seconds: 3) == 3
    end

    test "mixed" do
      assert time_description_to_seconds(weeks: 3, days: 3, hours: 3, minutes: 3, seconds: 3) == 2_084_583
    end
  end
end
