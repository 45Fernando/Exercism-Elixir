defmodule Frequency do
  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency([], _workers) do
    %{}
  end

  def frequency(texts, workers) do
    pattern = [",", ".", ";"]
    texts
    |> Stream.map(&String.downcase/1)
    |> Enum.map(&String.split(&1, pattern))
    |> List.flatten
    |> Task.async_stream(Frequency, :count, [], max_concurrency: workers)
    |> Enum.to_list
    |> Enum.reduce(%{}, fn({:ok, map}, acc) ->
        Map.merge(map, acc, fn(_dkey, value1, value2) -> value1 + value2 end)
      end)

  end


  # Counting letters
  def count(string) do
    lista = String.graphemes(string)
    countletters(lista, %{})
  end

  def countletters([], map) do
    map
  end

  def countletters([h | t], map) do
    case Regex.match?(~r/\p{L}/, h) do
      true ->
        map = Map.update(map, h, 1, &(&1 + 1))
        countletters(t, map)
      false ->  countletters(t, map)
    end

  end


end
