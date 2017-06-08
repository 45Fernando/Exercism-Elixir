defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    number
    |> factors(candidates(number), [])
    |> Enum.reverse
  end

  defp factors(1, _candidate, list) do
    list
  end

  defp factors(number, [], list) do
    [number | list]
  end

  defp factors(number, [h | t] = candidates, list) do
    case rem(number, h) do
      0 -> factors(div(number, h), candidates, [h | list])
      _ -> factors(number, t, list)
    end
  end

  defp candidates(number) do
    for num <- 3..round(:math.sqrt(number)),
        &Integer.is_odd/1,
        into: [2],
        do: num
  end
end
