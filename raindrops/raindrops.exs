defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    lista_divisores = divisores(number, number, [])

    lista_divisores
    |> Enum.reduce([],fn(x,acc) -> if x == 3 || x == 5 || x == 7 do
        [x | acc]
      else
        acc
    end
      end)
    |> Enum.reverse
    |> chequea(number)
  end

  def chequea(lista,number) do
    case lista do
      [_ | _] -> output(lista)
      [] -> to_string(number)
    end
  end

  def output(lista) do
    lista
    |> Enum.map(fn(x) -> decir(x) end)
    |> Enum.join
  end

  def decir(elemento) do
    case elemento do
      3 -> "Pling"
      5 -> "Plang"
      7 -> "Plong"
    end
  end

  def divisores(1,_number,lista) do
    [1 | lista]
  end

  def divisores(div, number, lista) do
    if rem(number, div) == 0  do
        divisores(div-1, number, [ div | lista ])
      else
        divisores(div-1, number, lista)
    end
  end


end
