defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert(digits, base_a, base_b) do
    cond do
      base_a <= 0 || base_b <= 1 ->
         nil    
      digits == [] ->
         nil
      Enum.any?(digits, fn(x) -> x < 0 end) == true ->
         nil
      Enum.any?(digits, fn(x) -> x >= base_a end) == true ->
         nil
      base_a == 10 ->
         base10aOtra(digits, base_b)
      base_b == 10 ->
         sumaP(Enum.reverse(digits), base_a, base_b, 0, 0)
      true ->
         sumaP(Enum.reverse(digits), base_a, 10, 0, 0)
         |> base10aOtra(base_b)
    end
  end

  defp sumaP([], _, _, _, numero) do
    numero
    |> round
    |> Integer.digits
  end

  defp sumaP([h | t], base_a, 10, exp, numero) do
      sumaP(t, base_a, 10, exp + 1, numero + (h * :math.pow(base_a, exp)) )
  end

  defp base10aOtra(digits, base_b) do
    digits
    |> Enum.join
    |> String.to_integer
    |> Integer.digits(base_b)
  end

end
