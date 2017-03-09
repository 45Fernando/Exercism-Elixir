defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @doc """
  Add a student to a particular grade in school.
  """
  @spec add(map, String.t, integer) :: map
  def add(db, name, grade) do
    case Map.fetch(db, grade) do
      {:ok, value} ->
        Map.put(db, grade, [name | value])
      :error ->
        Map.put(db, grade, [name])
    end
  end

  @doc """
  Return the names of the students in a particular grade.
  """
  @spec grade(map, integer) :: [String.t]
  def grade(db, grade) do
    case Map.fetch(db, grade) do
      {:ok, value} -> value
      :error -> []
    end
  end

  @doc """
  Sorts the school by grade and name.
  """
  @spec sort(map) :: [{integer, [String.t]}]
  def sort(db) when is_list(db) do
    Enum.sort(db)
  end

  def sort(db) do
    db
    |> Enum.map(fn({key, value}) ->
        value = Enum.sort(value)
        {key, value}
      end)
  end
end
