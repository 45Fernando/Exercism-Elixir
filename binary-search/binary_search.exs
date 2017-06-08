defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    ini = 0
    fin = tuple_size(numbers) - 1
    binary_search(numbers, ini, fin, key)
  end

  defp binary_search(_numbers, ini, fin, _buscado) when ini > fin do
    :not_found
  end

  defp binary_search(numbers, ini, fin, buscado) do
    med = div(ini + fin, 2)
    cond do
      elem(numbers, med) == buscado -> {:ok, med}
      elem(numbers, med) > buscado ->
        binary_search(numbers, ini, med - 1, buscado)
      true ->
        binary_search(numbers, med + 1, fin, buscado)
    end
  end
end
