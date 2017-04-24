defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """

  @teams ["Allegoric Alaskans", "Blithering Badgers", "Devastating Donkeys", "Courageous Californians"]
  #Example => [w,d,l]
  @regmatches %{"Allegoric Alaskans" => [0,0,0], "Blithering Badgers" => [0,0,0],
              "Devastating Donkeys" => [0,0,0],"Courageous Californians" => [0,0,0]}

  @r ["win", "loss", "draw"]

  #31 characters before |
  @result ~s(Team                           | MP |  W |  D |  L |  P)

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
    |> Enum.map(&String.split(&1, ";"))
    |> calculatematch(@regmatches)
    |> Enum.reduce([], fn({key,value},acc) -> [[value,key] | acc] end)
    |> Enum.sort(&criteria(&1, &2))
    |> formresult(@result)
  end

  defp calculatematch([], map) do
    map
  end

  defp calculatematch([[t1,t2,r] | tail], map) when t1 in @teams and t2 in @teams and r in @r do
    map = case r do
          "win" ->
            [w,d,l] = Map.get(map, t1)
            map = Map.put(map,t1, [w+1,d,l])
            [w,d,l] = Map.get(map, t2)
            Map.put(map, t2, [w,d,l+1])
          "loss" ->
            [w,d,l] = Map.get(map, t1)
            map = Map.put(map,t1, [w,d,l+1])
            [w,d,l] = Map.get(map, t2)
            Map.put(map, t2, [w+1,d,l])
          "draw" ->
            [w,d,l] = Map.get(map, t1)
            map = Map.put(map,t1,[w,d+1,l])
            [w,d,l] = Map.get(map, t2)
            Map.put(map, t2, [w,d+1,l])
        end
    calculatematch(tail, map)
  end

  defp calculatematch([_h | tail], map) do
    calculatematch(tail, map)
  end

  defp formresult([], string) do
    string
  end

  defp formresult([[[0,0,0], _team] | t], string) do
    formresult(t, string)
  end

  defp formresult([[[w,d,l], team] | t], string) do
    n = 31 - String.length(team)
    spaces = String.duplicate(" ", n)
    p = 3*w + d
    mp = w+d+l
    string = string <> ~s(\n#{team}#{spaces}|  #{mp} |  #{w} |  #{d} |  #{l} |  #{p})

    formresult(t, string)
  end

  defp criteria([m1,t1], [m2,t2]) do
    cond do
      m1 > m2 -> true
      m1 == m2 -> cond do
                  t1 < t2 -> true
                  true -> false
                 end
     true -> false
    end
  end

end
