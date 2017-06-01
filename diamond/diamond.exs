defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    firstletter = ?A
    dist = (letter - firstletter) * 2 + 1
    build_shape(letter, firstletter, dist, 0, []) <> "\n"

  end

  defp build_shape(letter, lett, _dist, _midspaces, [h | t]) when lett > letter do
    inverted = Enum.reverse(t)
    lista = [h | t]
    lista = [inverted | lista]

    lista
    |> List.flatten
    |> Enum.join("\n")

  end

  defp build_shape(letter, 65, dist ,midspaces, lista)  do
    spaces = div(dist, 2)
    cadena = String.duplicate(" ", spaces) <> <<65::utf8>> <> String.duplicate(" ", spaces)

    build_shape(letter, 66, dist, midspaces + 1, [cadena | lista])
  end

  defp build_shape(letter, lett, dist, midspaces, lista)  do
    spaces = div(dist - midspaces - 2, 2);  
    cadena = String.duplicate(" ", spaces) <> <<lett::utf8>> <>
             String.duplicate(" ", midspaces) <> <<lett::utf8>> <>
             String.duplicate(" ", spaces)

    build_shape(letter, lett + 1, dist, midspaces + 2, [cadena | lista])
  end
end
