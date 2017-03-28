defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @vowels1 ["a", "e", "i", "o", "u"]
  @vowels2 ["yt", "xr"]
  @consonants1 ["ch", "qu", "th"]
  @consonants2 ["squ", "thr", "sch"]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
    |> String.split
    |> Stream.map(&ptranslate(&1))
    |> Enum.join(" ")
  end

  defp ptranslate(<<c::binary-size(2)>> <> _resto = phrase) when c in @vowels2 do
      add(phrase)
  end

  defp ptranslate(<<c>> <> _resto = phrase) when <<c>> in @vowels1 do
    add(phrase)
  end

  defp ptranslate(<<c::binary-size(3)>> <> resto) when c in @consonants2 do
      add(resto <> c)
  end

  defp ptranslate(<<c::binary-size(2)>> <> resto) when c in @consonants1 do
      add(resto <> c)
  end

  defp ptranslate(<<c>> <> resto) do
    add(resto <> <<c>>)
  end

  defp add(cad) do
    cad<>"ay"
  end
end
