defmodule Atbash do
  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """

  # numbers -> ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
  @numbers [49, 50, 51, 52, 53, 54, 55, 56, 57, 58]
  @patterns [" ", ",", "."]

  @spec encode(String.t) :: String.t
  def encode(plaintext) do
    plaintext
    |> String.downcase
    |> String.replace(@patterns, "")
    |> to_charlist
    |> pencode
    |> Stream.chunk(5, 5, [])
    |> Stream.map(&to_string/1)
    |> Enum.join(" ")
  end

  defp pencode([]) do
    []
  end

  defp pencode([h | t]) when h in @numbers do
    [h | pencode(t)]
  end

  defp pencode([h | t])do
    [?z - h + 97  | pencode(t)]
  end

  @spec decode(String.t) :: String.t
  def decode(cipher) do
    cipher
    |> String.replace(@patterns, "")
    |> to_charlist
    |> pencode
    |> to_string
  end

end
