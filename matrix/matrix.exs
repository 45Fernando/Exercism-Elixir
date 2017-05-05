defmodule Matrix do
  defstruct matrix: %{1 => [], 2 => [], 3 => []}

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    input
    |> String.split("\n")
    |> Stream.map(fn(x)-> String.replace(x," ", "") end)
    |> Stream.map(fn(x) -> String.to_integer(x) end)
    |> Enum.map(fn(x) -> Integer.digits(x) end)
    |> matriz(%Matrix{},1)
  end

  defp matriz([], mat, _key) do
    mat
  end

  defp matriz([h | t], %{matrix: map} = m, key) do
    map = Map.put(map, key, h)
    m = %{m | matrix: map}
    matriz(t, m, key+1)
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%{matrix: map}) do
    map
    |> Map.to_list
    |> Stream.map(fn({_key,value}) -> value end)
    |> Stream.map(fn(x)-> Enum.join(x," ") end)
    |> Enum.join("\n")
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%{matrix: map}) do
    map
    |> Map.to_list
    |> Enum.map(fn({_key,value}) -> value end)
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%{matrix: map}, index) do
    map[index + 1]
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    rows(matrix)
    |> Enum.zip
    |> Enum.map(fn(x) -> Tuple.to_list(x) end)
  end
  
  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    columnas = columns(matrix)
    Enum.at(columnas, index)
  end
end
