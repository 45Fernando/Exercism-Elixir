defmodule Garden do
  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @plants %{"G" => :grass, "C" => :clover, "R" => :radishes, "V" => :violets}

  @students %{:alice => {},:bob => {}, :charlie => {},:david => {},
   :eve => {}, :fred => {}, :ginny => {}, :harriet => {},
   :ileana => {}, :joseph => {}, :kincaid => {}, :larry => {}}

  @spec info(String.t(), list) :: map
  def info(info_string,
    student_names \\ [:alice,:bob, :charlie,:david, :eve, :fred, :ginny, :harriet,
     :ileana, :joseph, :kincaid, :larry]) do
    [is1, is2] = String.split(info_string, "\n")
    student_names = Enum.sort(student_names)

    decode(is1, is2, student_names, @students)
  end

  defp decode(<<>>, <<>>, [], map) do
    map
  end

  defp decode(<<>>, <<>>, [h|t], map) do
    map = Map.put(map, h, {})
    decode(<<>>, <<>>, t, map)
  end

  defp decode(<<c1>> <> <<c2>> <> rest1, <<d1>> <> <<d2 >> <> rest2, [h | t], map) do
    plants = {
      Map.get(@plants, <<c1>>),
      Map.get(@plants, <<c2>>),
      Map.get(@plants, <<d1>>),
      Map.get(@plants, <<d2>>)
    }

    map = Map.update(map, h, plants, fn(_x) -> plants end )
    decode(rest1, rest2, t, map)
  end
end
