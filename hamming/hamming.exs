defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: non_neg_integer
  def hamming_distance(strand1, strand2) do
    cond  do
      length(strand1) != length(strand2) -> {:error, "Lists must be the same length"}      
      true ->  distancia(strand1, strand2, 0)
    end
  end

  defp distancia([], [], cont) do
    {:ok, cont}
  end

  defp distancia([h1 | t1], [h2 | t2], cont) do
    cond do
      h1 == h2 -> distancia(t1, t2, cont)
      true -> distancia(t1, t2, cont + 1)
    end
  end
end
