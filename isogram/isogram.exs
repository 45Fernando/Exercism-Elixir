defmodule Isogram do
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    sentence
    |> String.replace(~r/[\s]/, "")
    |> String.replace(~r/-/, "")
    |> String.downcase
    |> String.graphemes
    |> Enum.reduce(%{}, &Map.update(&2, &1, 1, fn x -> x + 1 end))
    |> Enum.all?(fn({_key, value}) -> value == 1 end)
  end

end
