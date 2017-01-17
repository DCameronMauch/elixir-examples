defmodule Shortcut do
  @charset_list ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N P Q R S T U V W X Y Z 1 2 3 4 5 6 7 8 9)
  @charset_size Enum.count(@charset_list)
  @required_bits :math.log2(@charset_size) |> Float.ceil |> trunc
  @required_bytes (@required_bits / 8) |> Float.ceil |> trunc
  @remainder_bits (@required_bytes * 8) - @required_bits
  @size_log :math.log(@charset_size)

  def generate(length) do
    generate(length, []) |> Enum.join
  end

  defp generate(0, list) do
    list
  end

  defp generate(length, list) do
    <<index::size(@required_bits), _::size(@remainder_bits)>> = :crypto.strong_rand_bytes(@required_bytes)

    if index >= @charset_size do
      generate(length, list)
    else
      generate(length - 1, [Enum.at(@charset_list, index) | list])
    end
  end

  def collision_probability(length) do
    :math.pow(@charset_size, length)
  end

  def length_for_probability(probability) do
    (:math.log(probability) / @size_log) |> Float.ceil |> trunc
  end
end
