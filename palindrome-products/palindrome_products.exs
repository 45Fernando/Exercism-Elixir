defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    generate_list(max_factor, min_factor)
    |> Enum.reduce(%{}, fn(x, acc)-> store_map(x, acc) end)
  end

  def generate_list(max, min) do
    for a <- min..max,
        b <- min..max,
        a <= b,
        is_palindrome?(a * b),
        do: {a*b, a, b}
  end

  def store_map({c, a , b}, map) do
    Map.update(map, c, [[a, b]], &[[a, b] | &1])
  end

  defp is_palindrome?(number) do
    number == reverse_number(number)
  end

  defp reverse_number(number) do
    number
    |> Integer.digits
    |> Enum.reverse
    |> Integer.undigits
  end
end
