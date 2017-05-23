defmodule PascalsTriangle do
  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(n) do
    pastriangle = cond do
                    n == 1 -> [[1]]
                    true -> prows(n, 2, [[1]])
                  end
    Enum.reverse(pastriangle)
  end

  defp prows(n, c, lista) when c > n do
    lista
  end

  defp prows(n, c, lista) do
    newrow = List.first(lista)
             |> formrow([])

    prows(n, c+1, [newrow | lista])
  end

  defp formrow([], newrow) do
    result(newrow)
  end

  defp formrow([_a], newrow) do
    result(newrow)
  end

  defp formrow([a, b | tail], newrow) do
    newrow = [a+b | newrow]
    formrow([b | tail], newrow)
  end

  defp result(newrow) do
    newrow
    |> List.insert_at(-1, 1)
    |> List.insert_at(0, 1)
    |> Enum.reverse
  end
end
