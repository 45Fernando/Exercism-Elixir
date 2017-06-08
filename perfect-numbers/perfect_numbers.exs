defmodule PerfectNumbers do
  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: ({ :ok, atom } | { :error, String.t() })
  def classify(number) when number <= 0 do
    { :error, "Classification is only possible for natural numbers." }
  end

  def classify(1) do
    {:ok, :deficient}
  end

  def classify(number) do
    number
    |> factors(2, [1])
    |> Enum.sum
    |> check(number)
  end

  defp factors(number, candidate, lista) when candidate * 2 > number do
    lista
  end

  defp factors(number, candidate, lista) do
    case rem(number, candidate) do
      0 -> factors(number, candidate + 1, [candidate | lista])
      _ -> factors(number, candidate + 1, lista)
    end
  end

  defp check(sum, number) do
    cond do
      sum == number -> {:ok, :perfect}
      sum > number  -> {:ok, :abundant}
      true          -> {:ok, :deficient}
    end
  end
end
