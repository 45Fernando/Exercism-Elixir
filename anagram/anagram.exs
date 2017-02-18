defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    candidates = candidates
                 |> Enum.filter(fn(x) ->
                    String.downcase(x) != base && verificar(base, x)
                  end)
  end

  def verificar(base, candidato) do
    base = base |> String.downcase |> String.graphemes
    candidato = candidato |> String.downcase |> String.graphemes

    cond do
      candidato -- base == [] && base -- candidato == []
        -> true
      true
        -> false
    end

  end
end
