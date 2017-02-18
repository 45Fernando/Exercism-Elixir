defmodule RNATranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna) do
    dna
    |> Enum.reduce('', fn(x, acc) ->  acc ++ cambiarLetra(x) end)
  end

  def cambiarLetra(letra) do
    case letra do
      71 -> 'C' #'G'
      67 -> 'G' #'C'
      84 -> 'A' #'T'
      65 -> 'U' #'A'
    end
  end
end
