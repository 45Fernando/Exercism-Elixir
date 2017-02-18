defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """



  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do

    letras = %{"a" => 0, "b" => 0, "c" => 0, "d" => 0, "e" => 0, "f" => 0, "g" => 0,
               "h" => 0, "i" => 0, "j" => 0, "k" => 0, "l" => 0, "m" => 0, "n" => 0,
               "o" => 0, "p" => 0, "q" => 0, "r" => 0, "s" => 0, "t" => 0, "u" => 0,
               "v" => 0, "x" => 0, "w" => 0, "y" => 0, "z" => 0}

    sentence
    |> String.downcase
    |> String.graphemes
    |> verificarMapa(letras)
    |> Enum.filter(fn({ _, valor}) ->
        valor == 0
      end
      )    
    |> Enum.empty?
  end

  def verificarMapa([], mapa) do
    mapa
  end

  def verificarMapa([h | t], mapa) do
    mapa = if Map.has_key?(mapa, h) do
            Map.update!(mapa, h, &(&1 + 1))
          else
            mapa
    end
    verificarMapa(t, mapa)
  end

end
