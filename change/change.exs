defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t}
  def generate(_, 0) do
    {:ok, []}
  end

  def generate([h | _] , target) when target < h or target < 0 do
    {:error, "cannot change"}
  end

  def generate(coins, target) do
    change = coins
             |> Enum.reverse
             |> checkchange(target)
             |> Stream.reject(&is_nil/1)
             |> Enum.sort_by(&length/1)
             |> List.first

     case change do
       nil -> {:error, "cannot change"}
       _ -> {:ok, Enum.sort(change)}
     end

  end

  defp checkchange([], _target) do
    []
  end

  defp checkchange([_h | t] = lista, target) do
    [checksublist(lista, target)| checkchange(t, target)]
  end

  defp checksublist(_, 0) do
    []
  end

  defp checksublist([], _target) do
    nil
  end

  defp checksublist([coin | t], target) when coin > target do
    checksublist(t, target)
  end

  defp checksublist([coin | t], target) do
    cociente = div(target, coin)
    resto = rem(target, coin)
    cond do
      n = checksublist(t, resto) -> List.duplicate(coin, cociente) ++ n
      n = checksublist(t, resto + coin) -> List.duplicate(coin, cociente-1) ++ n
      true -> nil
    end
  end
end
