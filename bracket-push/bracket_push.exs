defmodule BracketPush do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """

  @comienzo ["{", "[", "("]
  @cierre ["}", "]", ")"]

  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    verifica(str, [])
  end

  def verifica(<<>>, listaA)do
    cond do
      Enum.empty?(listaA)
        -> true
      true -> false
    end
  end

  def verifica(<<car>> <> resto, listaA) when <<car>> in @comienzo do
    verifica(resto, [<<car>> | listaA])
  end

  def verifica(<<car>> <> resto, [ha | ta]) when <<car>> in @cierre do
    if chekea(ha, <<car>>) do
      verifica(resto, ta)
    else
      false
    end
  end

  def verifica(<<_car>> <> resto, listaA) do
    verifica(resto, listaA)
  end

  def chekea(ha, hc) do
    cond do
      ha == "{" && hc == "}" -> true
      ha == "[" && hc == "]" -> true
      ha == "(" && hc == ")" -> true
      true -> false
    end
  end

end
