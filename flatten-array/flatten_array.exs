defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten(list) do
    pflatten(list, [])
    |> Enum.reverse
  end

  defp pflatten([], list) do
    list
  end

  defp pflatten([h | t], list) do
    case h do
      [] -> pflatten(t, list)
      [_ | _] ->
        list = pflatten(h, list)        
        pflatten(t, list)
      nil -> pflatten(t, list)
      _ -> pflatten(t, [h | list])
    end
  end

end
