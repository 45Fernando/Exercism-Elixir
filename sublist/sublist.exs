defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """

  def compare([nil], []) do
    :superlist
  end

  def compare([], [nil]) do
    :sublist
  end

  def compare(a, b) do
    cond do
      a == b -> :equal
      chekea(a, b) -> :sublist
      chekea(b, a) -> :superlist
      true -> :unequal
    end
  end

  def chekea( _a, []) do
    false
  end

  def chekea(a, [ _hb | tb] = b) do
    cond do
      comienza(a,b) -> true
      true -> chekea(a,tb)
    end
  end


  def comienza([], _b) do
    true
  end

  def comienza( _a, []) do
    false
  end

  def comienza([ha | ta], [hb | tb]) do
    cond do
      ha === hb -> comienza(ta, tb)
      true -> false
    end
  end

end
