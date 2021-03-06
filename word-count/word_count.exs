defmodule Words do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count(sentence) do
    pattern = :binary.compile_pattern([",", " ","_"])
    sentence
    |>String.split(pattern, trim: true)
    |>Stream.map(&String.downcase/1)    
    |>Enum.reduce(%{}, &Map.update(&2, &1, 1, fn x -> x + 1 end))
  end
end
