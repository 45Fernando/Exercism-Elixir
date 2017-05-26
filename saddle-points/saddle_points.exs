defmodule SaddlePoints do
  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    str
    |> String.split("\n")
    |> Stream.map(fn(x)-> String.split(x) end)
    |> Enum.map(fn(x) ->
      x
      |> Enum.map(&String.to_integer/1)
     end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str) do
    str
    |> rows
    |> Enum.zip
    |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    allrows = rows(str)
    mayrows =  mayor_rows(allrows)

    mincolumns =
      str
      |> columns
      |> minim_columns

    saddle_point(allrows, mayrows, mincolumns, [], 0)
  end

  def saddle_point([], _, _, saddlelist, _r) do
    saddlelist
    |> Enum.reverse
  end

  def saddle_point([row | tail], [mayrow | tailmay], mincolumns, saddlelist, r) do
    saddlelist = check_element(row, mayrow, mincolumns, saddlelist, r, 0)

    saddle_point(tail, tailmay, mincolumns, saddlelist, r+1)
  end

  def check_element([], _mayrow, _mincol, saddlelist, _r, _c) do
    saddlelist
  end

  def check_element([a | tail], mayrow, [mc | mintail], saddlelist, r, c) do
    cond do
      a == mayrow && a == mc ->
        check_element(tail, mayrow, mintail, [{r, c} | saddlelist], r, c + 1)
      true ->   check_element(tail, mayrow, mintail, saddlelist, r, c + 1)
    end
  end

  def mayor_rows(allrows) do
    allrows
    |> Enum.map(fn(x)-> Enum.max(x) end)
  end

  def minim_columns(allcolumns) do
    allcolumns
    |> Enum.map(fn(x)-> Enum.min(x) end)
  end
end
