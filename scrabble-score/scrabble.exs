defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """

  @espacios [" ", "\t", "\n"]
  @letras1 ["a", "e", "i", "o", "u", "l", "n", "r", "s", "t"]
  @letras2 ["d", "g"]
  @letras3 ["b", "c", "m", "p"]
  @letras4 ["f", "h", "v", "w", "y"]
  @letras5 ["k"]
  @letras8 ["j", "x"]
  @letras10 ["q", "z"]

  @spec score(String.t) :: non_neg_integer
  def score(string) do
    contar(String.downcase(string), 0)
  end

  def contar(<<>>, acu) do
    acu + 0
  end

  def contar(<<letra>> <> resto, acu) when <<letra>> in @espacios do
    contar(resto, acu+0)
  end

  def contar(<<letra>> <> resto, acu) when <<letra>> in @letras1 do
    contar(resto, acu+1)
  end

  def contar(<<letra>> <> resto, acu) when <<letra>> in @letras2 do
    contar(resto, acu+2)
  end

  def contar(<<letra>> <> resto, acu) when <<letra>> in @letras3 do
    contar(resto, acu+3)
  end

  def contar(<<letra>> <> resto, acu) when <<letra>> in @letras4 do
    contar(resto, acu+4)
  end

  def contar(<<letra>> <> resto, acu) when <<letra>> in @letras5 do
    contar(resto, acu+5)
  end

  def contar(<<letra>> <> resto, acu) when <<letra>> in @letras8 do
    contar(resto, acu+8)
  end

  def contar(<<letra>> <> resto, acu) when <<letra>> in @letras10 do
    contar(resto, acu+10)
  end
end
