defmodule Phone do
  @doc """
  Remove formatting from a phone number.

  Returns "0000000000" if phone number is not valid
  (10 digits or "1" followed by 10 digits)

  ## Examples

  iex> Phone.number("123-456-7890")
  "1234567890"

  iex> Phone.number("+1 (303) 555-1212")
  "3035551212"

  iex> Phone.number("867.5309")
  "0000000000"
  """
  @numeros ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

  @spec number(String.t) :: String.t
  def number(raw) do
    if Regex.run(~r/[a-z]/, raw) == nil do
      raw
      |> String.graphemes
      |> Stream.filter(fn(x) -> numero?(x) end)
      |> Enum.join
      |> verificar
    else
      "0000000000"
    end
  end

  def numero?(x) do
    if x in @numeros do
      true
    else
      false
    end
  end

  def verificar(cadena) do
    cond do
      String.length(cadena) < 10
        -> "0000000000"
      String.length(cadena) == 10
        -> cadena
      String.length(cadena) == 11 && String.first(cadena) == "1"
        -> sacarPrimero(cadena)
      String.length(cadena) == 11 && String.first(cadena) != "1"
        -> "0000000000"
      String.length(cadena) > 11
        -> "0000000000"
    end
  end

  def sacarPrimero(<<_letra>> <> resto) do
    resto
  end

  @doc """
  Extract the area code from a phone number

  Returns the first three digits from a phone number,
  ignoring long distance indicator

  ## Examples

  iex> Phone.area_code("123-456-7890")
  "123"

  iex> Phone.area_code("+1 (303) 555-1212")
  "303"

  iex> Phone.area_code("867.5309")
  "000"
  """
  @spec area_code(String.t) :: String.t
  def area_code(raw) do
    raw = number(raw)
    {area, _resto} = extraerArea(raw)
    area
  end

  def extraerArea(<<a>> <> <<b>> <> <<c>> <> resto) do
    {<<a>> <> <<b>> <> <<c>>, resto}
  end

  @doc """
  Pretty print a phone number

  Wraps the area code in parentheses and separates
  exchange and subscriber number with a dash.

  ## Examples

  iex> Phone.pretty("123-456-7890")
  "(123) 456-7890"

  iex> Phone.pretty("+1 (303) 555-1212")
  "(303) 555-1212"

  iex> Phone.pretty("867.5309")
  "(000) 000-0000"
  """
  @spec pretty(String.t) :: String.t
  def pretty(raw) do
    raw = number(raw)
    {area, resto} = extraerArea(raw)
    armarNumero(area,resto)
  end

  def armarNumero(area, resto) do
    {cod, resto} = extraerArea(resto)
    "(" <> area <> ")" <> " " <> cod <> "-" <> resto
  end
end
