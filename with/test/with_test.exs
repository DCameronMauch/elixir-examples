defmodule WithTest do
  use ExUnit.Case

  describe "process/1" do
    test "valid data" do
      data = ["2016-01-01T00:00:00Z|1.1", "2016-01-02T01:02:03Z|2.2"]
      expected = [{1451606400, 1.1}, {1451696523, 2.2}]
      assert With.process(data) == expected
    end

    test "unsplittable line" do
      data = ["2016-01-01T00:00:00Z|1.1", "2016-01-02T01:02:03Z|2.2|something"]
      expected = {:error, "not splittable on line 2"}
      assert With.process(data) == expected
    end

    test "invalid datetime" do
      data = ["2016-01-01T00:00:00Z|1.1", "something|2.2"]
      expected = {:error, "invalid datetime on line 2"}
      assert With.process(data) == expected
    end

    test "invalid value" do
      data = ["2016-01-01T00:00:00Z|1.1", "2016-01-02T01:02:03Z|something"]
      expected = {:error, "invalid value on line 2"}
      assert With.process(data) == expected
    end
  end

  describe "index/1" do
    test "successful index" do
      data = ["foo", "bar"]
      expected = [{1, "foo"}, {2, "bar"}]
      assert With.index(data) == expected
    end

    test "empty list" do
      assert With.index([]) == []
    end
  end

  describe "split/1" do
    test "successful split" do
      data = [{1, "abc|123"}, {2, "def|456"}]
      expected = [{1, "abc", "123"}, {2, "def", "456"}]
      assert With.split(data) == expected
    end

    test "successful split with spaces" do
      data = [{1, " abc | 123 "}]
      expected = [{1, "abc", "123"}]
      assert With.split(data) == expected
    end

    test "with unsplitable line" do
      data = [{1, "abc|123"}, {2, "foobar"}]
      expected = {:not_slittable, 2}
      assert With.split(data) == expected
    end
  end

  describe "epochs/1" do
    test "successful epochs" do
      data = [{1, "2016-01-01T00:00:00Z", "foo"}, {2, "2016-01-02T01:02:03Z", "bar"}]
      expected = [1451606400, 1451696523]
      assert With.epochs(data) == expected
    end

    test "invalid datetime" do
      data = [{1, "2016-01-01T00:00:00Z", "something"}, {2, "foo", "bar"}]
      expected = {:not_datetime, 2}
      assert With.epochs(data) == expected
    end
  end

  describe "values/1" do
    test "successful values" do
      data = [{1, "foo", "1.1"}, {2, "bar", "2.2"}]
      expected = [1.1, 2.2]
      assert With.values(data) == expected
    end

    test "invalid value" do
      data = [{1, "foo", "1.1"}, {2, "bar", "something"}]
      expected = {:not_value, 2}
      assert With.values(data) == expected
    end
  end
end
