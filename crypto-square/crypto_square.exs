defmodule CryptoSquare do
  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  @pattern [" ", ",", "!", "'", "."]
  def encode(""), do: ""
  def encode(str) do
    str
    |> String.replace(@pattern, "")
    |> String.downcase
    |> in_rows()

  end

  defp in_rows(string) do
    {c, r} =
      string
      |> row_x_colum
      |> List.first

    string
    |> String.pad_trailing(c * r, " ")
    |> String.graphemes
    |> Stream.chunk(c)
    |> Stream.zip
    |> Stream.map(&Tuple.to_list/1)
    |> Enum.map(&clean_spaces/1)
    |> Enum.join(" ")
  end


  defp row_x_colum(string) do
    len = range(string)

    for c <- 1..len,
        r <- 1..len,
        c >= r,
        c * r >= String.length(string),
        c - r <= 1,
        do: {c, r}
  end

  defp clean_spaces(list) do
    list
    |> Enum.join
    |> String.trim
  end

  defp range(string) do
    string
    |> String.length
    |> :math.sqrt
    |> round
    |> Kernel.+(1)
  end

end
