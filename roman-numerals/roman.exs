defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """

  @spec numerals(pos_integer) :: String.t
  def numerals(number) do
    cambiar(rem(number,10), 0, div(number,10), "")
  end

  def cambiar(0, _, 0, cadena) do
    cadena
  end

  def cambiar(0,cont, resto_num, cadena) do
    cambiar(rem(resto_num,10), cont+1, div(resto_num, 10), cadena)
  end

  def cambiar(dig, cont, resto_num, cadena) when cont == 0 do
    letra = case dig do
        1 -> "I"
        2 -> "II"
        3 -> "III"
        4 -> "IV"
        5 -> "V"
        6 -> "VI"
        7 -> "VII"
        8 -> "VIII"
        9 -> "IX"
      end
    cambiar(rem(resto_num,10), cont+1, div(resto_num, 10), letra <> cadena)
  end

  def cambiar(dig, cont, resto_num, cadena) when cont == 1 do
    letra = case dig do
        1 -> "X"
        2 -> "XX"
        3 -> "XXX"
        4 -> "XL"
        5 -> "L"
        6 -> "LX"
        7 -> "LXX"
        8 -> "LXXX"
        9 -> "XC"
      end
    cambiar(rem(resto_num,10), cont+1, div(resto_num, 10), letra <> cadena)
  end

  def cambiar(dig, cont , resto_num, cadena) when cont == 2 do
    letra = case dig do
        1 -> "C"
        2 -> "CC"
        3 -> "CCC"
        4 -> "CD"
        5 -> "D"
        6 -> "DC"
        7 -> "DCC"
        8 -> "DCCC"
        9 -> "CM"
      end
    cambiar(rem(resto_num,10), cont+1, div(resto_num, 10), letra <> cadena)
  end

  def cambiar(dig, cont, resto_num, cadena) when cont == 3do
    letra = case dig do
        1 -> "M"
        2 -> "MM"
        3 -> "MMM"
      end
    cambiar(rem(resto_num,10), cont+1, div(resto_num, 10), letra <> cadena)
  end

end
