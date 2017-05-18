defmodule Queens do
  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new(white\\{0, 3}, black\\{7, 3}) do
    cond  do
      white != black ->
        %Queens{black: black, white: white}
      true ->
        raise(ArgumentError, message: "the argument value is invalid")
    end
  end

  @table %{
    0 => "_ _ _ _ _ _ _ _",
    1 => "_ _ _ _ _ _ _ _",
    2 => "_ _ _ _ _ _ _ _",
    3 => "_ _ _ _ _ _ _ _",
    4 => "_ _ _ _ _ _ _ _",
    5 => "_ _ _ _ _ _ _ _",
    6 => "_ _ _ _ _ _ _ _",
    7 => "_ _ _ _ _ _ _ _"
  }
  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """
  @spec to_string(Queens.t()) :: String.t()
  def to_string(%{black: {br, bc}, white: {wr, wc}}) do
    @table
    |> putQueen(wr, wc, "W")
    |> putQueen(br, bc, "B")
    |> Enum.map(fn({_key, value})-> value end)
    |> Enum.join("\n")
  end

  defp putQueen(table, r, c, piece) do
    {subr1, subr2} =
      table
      |> Map.get(r)
      |> String.split_at(c * 2)

    row = subr1 <> String.replace_prefix(subr2, "_", piece)
    Map.put(table, r, row)
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(%{black: {br, bc}, white: {wr, wc}}) do
    cond do
      br == wr -> true
      bc == wc -> true
      abs(br - wr) == abs(bc - wc) -> true
      true -> false
    end
  end

end
