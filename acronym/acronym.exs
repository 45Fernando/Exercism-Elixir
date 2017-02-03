defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    #pattern = :binary.compile_pattern([",", " ","_"])
    string
    |> String.replace(~r/[^\w]/, " ")
    |> separar
    |> String.upcase
    |> String.split  
    |> Enum.reduce("", fn(x,acc) -> acc <> String.first(x) end)
  end

  #A tryng to past the 3rd test, not working.
  def separar(string) do
    Regex.replace(~r/[A-Z]/, string, " \\0")
  end
end
