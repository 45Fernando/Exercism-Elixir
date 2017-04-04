defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """

  @handshake %{1 => "wink", 10 => "double blink", 100 => "close your eyes", 1000 => "jump", 10000 => :reverse}
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    digits = code |> Integer.digits(2) |> Enum.reverse

    pcommands(digits, 0, [], 0)
  end

  defp pcommands([], _cont, list, 0) do
    list
    |> Enum.reverse
  end

  defp pcommands([], _cont, list, 1) do
    list
  end

  defp pcommands([h | t], cont, list, band) do
    h = h * :math.pow(10, cont) |> round
    word = Map.get(@handshake, h)
    case word do
      nil ->
        pcommands(t, cont + 1, list, band)
      :reverse ->
        pcommands(t, cont + 1, list, 1)
      _ ->
        pcommands(t, cont + 1 , [word | list], band)
    end
  end

end
