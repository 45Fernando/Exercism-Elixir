defmodule Wordy do

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question) do
    pattern = ["?", "What is "]

    question
    |> String.replace(pattern, "")
    |> String.split
    |> Enum.reject(fn(x) -> x == "by" end)
    |> convert
    |> verify
  end

  defp convert([]) do
    []
  end

  defp convert([h | t]) do
    try do
      [String.to_integer(h) | convert(t)]
    rescue
      ArgumentError -> [h | convert(t)]
    end
  end

  defp verify(lista) do
    cond  do
      check(lista) -> raise ArgumentError
      true -> operate(lista)
    end
  end

  defp check(lista) do
    Enum.any?(lista, fn(x) -> x == "cubed" end) || Enum.all?(lista, fn(x) -> !is_integer(x) end)
  end

  defp operate([result]) do
    result
  end

  defp operate([n1, op, n2 | tail]) do
    case op do
      "plus" -> operate([n1 + n2 | tail])
      "minus" -> operate([n1 - n2 | tail])
      "multiplied" -> operate([n1 * n2 | tail])
      "divided" -> operate([div(n1, n2) | tail])
    end
  end
end
