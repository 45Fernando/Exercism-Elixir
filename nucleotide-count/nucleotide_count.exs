defmodule NucleotideCount do
  @nucleotides [?A, ?C, ?G, ?T]

  @doc """
  Counts individual nucleotides in a NucleotideCount strand.

  ## Examples

  iex> NucleotideCount.count('AATAA', ?A)
  4

  iex> NucleotideCount.count('AATAA', ?T)
  1
  """
  @spec count([char], char) :: non_neg_integer
  def count(strand, nucleotide) do
    strand
    |>Enum.reduce(0, fn(x,acc) -> if x == nucleotide do
      acc + 1 else acc end
    end )
  end



  @doc """
  Returns a summary of counts by nucleotide.

  ## Examples

  iex> NucleotideCount.histogram('AATAA')
  %{?A => 4, ?T => 1, ?C => 0, ?G => 0}
  """
  @spec histogram([char]) :: map
  def histogram(strand) do
    cuenta(strand,@nucleotides,%{})
  end

  def cuenta(_, [], map) do
    map
  end

  def cuenta(strand,[head | tail],map) do
    valor = count(strand,head)
    map = Map.put(map, head,valor)
    cuenta(strand,tail,map)
  end
end
