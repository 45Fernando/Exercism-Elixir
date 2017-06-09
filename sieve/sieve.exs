defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit) do
    limit
    |> generate_range
    |> filter([])
    |> Enum.reverse
  end

  defp filter([], lista) do
    lista
  end

  defp filter([h | t], lista) do
    t = t |> Enum.filter(fn(x) -> rem(x, h) != 0 end)

    filter(t, [h | lista])
  end

  defp generate_range(limit) do
    for n <- 3..limit,
        &Integer.is_odd/1,
        into: [2],
        do: n
  end

end
