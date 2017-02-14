defmodule Behaviours.Human do
  @behaviour Behaviours

  def talk(message), do: "#{message} back at ya"
end
