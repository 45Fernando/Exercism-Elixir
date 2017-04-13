defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"ability" => "a", "aardvark" => "a", "ballast" => "b", "beauty" =>"b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    input
    |> Enum.reduce(%{}, fn({key,values}, acc) ->
      values
      |> Enum.map(&String.downcase/1)
      |> ptransform(key,acc)
     end)
  end

  defp ptransform([], _key, map) do
    map
  end

  defp ptransform([h | t], key, map) do
    map = Map.put(map, h, key)
    ptransform(t, key, map)
  end
end
