defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.filter`.
  """
  @spec keep(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def keep([], _fun) do
    []
  end

  def keep([h | t], fun) do
    cond do
      fun.(h) == true ->
        [h | keep(t,fun)]
      true ->
        keep(t, fun)
    end
  end

  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.

  Do not use `Enum.reject`.
  """
  @spec discard(list :: list(any), fun :: ((any) -> boolean)) :: list(any)
  def discard([], _fun) do
    []
  end

  def discard([h | t], fun) do
    cond do
      fun.(h) == true ->
        discard(t, fun)
      true ->
        [h | discard(t, fun)]
    end
  end
end
