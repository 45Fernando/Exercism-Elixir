defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) do
    valor(2,1,count)
  end

  def es_primo(x) do
     2..(div(x, 2))
     |> Enum.filter(fn a -> rem(x, a) == 0 && a != 1 end)
     |> length() == 0
  end

  def valor(_,_,0) do
    raise ArgumentError, "Tine que ser mayor que cero"
  end
  def valor(2,1,1) do
    2
  end

  def valor(num ,cont,limite) when cont == limite do
    num - 1
  end

  def valor(num,cont,limite) do
    case es_primo(num) do
      true -> valor(num + 1, cont + 1, limite)
      false -> valor(num + 1, cont, limite)
    end
  end

end
