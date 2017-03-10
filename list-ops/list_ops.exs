defmodule ListOps do
  # Please don't use any external modules (especially List) in your
  # implementation. The point of this exercise is to create these basic functions
  # yourself.
  #
  # Note that `++` is a function from an external module (Kernel, which is
  # automatically imported) and so shouldn't be used either.

  @spec count(list) :: non_neg_integer
  def count(l) do
    count(l, 0)
  end

  defp count([], cont) do
    cont
  end

  defp count([h | t], cont) do
    count(t, cont + 1)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    reverse(l, [])
  end

  defp reverse([], l) do
    l
  end

  defp reverse([h | t], l) do
    reverse(t, [h | l])
  end

  @spec map(list, (any -> any)) :: list
  def map([], _f) do
    []
  end

  def map([h | t], f) do
    [f.(h) | map(t, f)]
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f) do
    []
  end

  def filter([h | t], f) do
    cond  do
      f.(h) -> [h | filter(t, f)]
      true -> filter(t, f)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, ((any, acc) -> acc)) :: acc
  def reduce([], acc, _f) do
    acc
  end

  def reduce([h | t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, []) do
    a
  end

  def append([], b) do
    b
  end

  def append(a,b) do
    pappend(reverse(a), b)
  end

  defp pappend([], b) do
    b
  end

  defp pappend([h | t], b) do
    pappend(t, [h | b])
  end

  @spec concat([[any]]) :: [any]
  def concat([]) do
    []
  end
  def concat([h, n | t]) do
    append(h,n) ++ concat(t)
  end
end
