defmodule RailFenceCipher do
  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode(str, rails) when rails == 1 or rails > byte_size(str) do
    str
  end
  def encode(str, rails) do
    rail = form_rails(rails)
    str = sanitize_string(str)

    p_encode(str, rail, rails)
    |> Enum.join
  end

  def p_encode(str, rail, rails) do
    p_encode(str, rail, 1, rails, :up)
    |> Map.to_list
    |> Enum.map(fn({_value, list})-> list |> Enum.reverse end)
  end

  def p_encode([], map, _0, _max, _way), do: map
  def p_encode([hc | tc], map, 1, max, _way) do
    map = Map.update!(map, 1, &[hc | &1])
    p_encode(tc, map, 2, max, :up)
  end

  def p_encode([hc | tc], map, count, max, _way ) when count == max do
    map = Map.update!(map, count, &[hc | &1])
    p_encode(tc, map, count - 1, max, :down)
  end

  def p_encode([hc | tc], map, count, max, way) do
    map = Map.update!(map, count, &[hc | &1])
    case way do
      :up -> p_encode(tc, map, count + 1, max, way)
      :down -> p_encode(tc, map, count - 1, max, way)
    end
  end

  def form_rails(rails) do
    1..rails
    |> Enum.map(fn(_x)-> [] end)
    |> Enum.with_index(1)
    |> Enum.reduce(%{}, fn({value, key}, acc)-> Map.put(acc, key, value) end)
  end

  defp sanitize_string(string) do
    string
    |> String.graphemes
  end

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode("", _), do: ""
  def decode(str, rails) when rails == 1 or rails > byte_size(str) do
    str
  end

  def decode(str, rails) do
    rail = form_rails(rails)
    str = sanitize_string(str)

    size = p_encode(str, rail, rails) |>  Enum.map(&length/1)

    form_r_decode(str, size, [])
    |> Enum.reverse
    |> p_decode(0, rails - 1, [], :up)
    |> Enum.reverse
    |> Enum.join

  end

  def form_r_decode([], _, list), do: list
  def form_r_decode(str, [sh | st], list) do
    chunk = Enum.take(str, sh)
    str = Enum.drop(str, sh)

    form_r_decode(str, st, [chunk | list])
  end

  def p_decode(r_list, 0, max, list, _way) do
    l = Enum.at(r_list, 0)
    case l do
      [] -> list
      _ ->
        {car, l} = List.pop_at(l, 0)
        r_list = List.replace_at(r_list, 0, l)

        p_decode(r_list, 1, max, [car | list], :up)
    end

  end

  def p_decode(r_list, count, max, list, _way) when count == max do
    l = Enum.at(r_list, count)
    case l do
      [] -> list
      _ ->
        {car, l} = List.pop_at(l, 0)
        r_list = List.replace_at(r_list, count, l)

        p_decode(r_list, count - 1, max, [car | list], :down)
    end
  end

  def p_decode(r_list, count, max, list, way)  do
    l = Enum.at(r_list, count)
    {car, l} = List.pop_at(l, 0)
    r_list = List.replace_at(r_list, count, l)

    case way do
      :up -> p_decode(r_list, count + 1, max, [car | list], way)
      :down -> p_decode(r_list, count - 1, max, [car | list], way)
    end
  end
end
