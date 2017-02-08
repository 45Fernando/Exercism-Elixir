defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    listaMultiplos(List.first(factors), factors, limit, [])
    |>Stream.uniq
    |>Enum.sum
  end

  def listaMultiplos(_a, [], _limit, multiplos) do
    multiplos
  end

  def listaMultiplos(a, [h | tail], limit, multiplos) when h < limit do
    listaMultiplos(a, [h + a | tail], limit, [h | multiplos])
  end

  def listaMultiplos(_a ,[_h | tail], limit, multiplos) do
    listaMultiplos(List.first(tail) ,tail, limit, multiplos)
  end


end
