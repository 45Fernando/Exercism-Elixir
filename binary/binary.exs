defmodule Binary do
  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    string
    |> String.reverse
    |> todecimal(0,0)
  end

  defp todecimal(<<>>, _exp, acc) do
    acc
  end

  defp todecimal(<<c>> <> resto, exp, acc) when <<c>> == "0" do
    todecimal(resto, exp+1, acc)
  end

  defp todecimal(<<c>> <> resto, exp, acc) when <<c>> == "1" do
     todecimal(resto, exp + 1, acc + :math.pow(2, exp))
  end

  defp todecimal(_string, _exp, _acc) do
    0
  end
end
