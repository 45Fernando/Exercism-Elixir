defmodule Hexadecimal do
  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @hextodec %{"0" => 0, "1" => 1, "2" => 2, "3" => 3, "4" => 4, "5" => 5,
              "6" => 6, "7" => 7, "8" => 8, "9" => 9, "a" => 10,
              "b" => 11, "c" => 12, "d" => 13, "e" => 14, "f" => 15,}

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    list =  hex
            |> String.downcase
            |> String.codepoints
            |> Stream.map(fn(x) -> Map.get(@hextodec, x, :notfound) end)
            |> Enum.reverse            

    cond do
      Enum.all?(list, fn(x) -> x != :notfound end) ->
        list
        |> Enum.with_index
        |> sumaPonderada

      true -> 0
    end
  end

  def sumaPonderada(list) do
    list
    |> Stream.map(fn({value, index}) -> value * round(:math.pow(16, index))  end)
    |> Enum.sum
  end

end
