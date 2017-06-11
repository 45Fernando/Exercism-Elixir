defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    middle(plaintext, key, &Kernel.+/2)
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    middle(ciphertext, key, &Kernel.-/2)
  end

  defp middle(text, key, f) do
    key =
      key
      |> to_charlist
      |> Stream.cycle
      |> Enum.take(String.length(text))

    text
      |> to_charlist
      |> encode_decode(key, f)
      |> to_string
  end

  defp encode_decode([], _keys, _f) do
    []
  end

  defp encode_decode([h | t], [key | key_t] = keys, f) do
    cond do
      h >= 97 && h <= 122 -> [check_less_cero(h, key, f) | encode_decode(t, key_t, f)]
      true -> [h | encode_decode(t, keys, f)]
    end
  end

  defp check_less_cero(h, key, f) do
    r = rem(f.(h - 97, key - 97), 26)
    cond do
      r >= 0 -> r + 97
      true -> 123 + r
    end
  end
end
