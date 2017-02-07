defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "HORSE" => "1H1O1R1S1E"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "1H1O1R1S1E" => "HORSE"
  """
  @numeros ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.codepoints
    |> armarCadena
  end

  def armarCadena(lista) do
    if Enum.empty?(lista) do
      ""
    else
      contar(lista, List.first(lista), "", 0)
    end

  end

  def contar([], letra, cadena, contador) do
    cadena <> to_string(contador) <> letra
  end

  def contar([head | tail], letra, cadena, contador) do
    if head == letra do
      contar(tail, letra, cadena, contador + 1)
    else
      contar(tail, head, cadena <> to_string(contador) <> letra, 1)
    end
  end

  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> separar
    |> armar("")
  end

  def armar([], cadena) do
    cadena
  end

  def armar([head | tail], cadena) do
    {cantidad, letra} = head

    cadena = for x <- 1..cantidad,
                into: cadena,
                do: letra
                    
    armar(tail, cadena)
  end

  def separar(cadena) do
    lista = listar(cadena, "", [])
    Enum.reverse(lista)
  end

  def listar(<<>>, _numero, lista) do
    lista
  end

  def listar(<<caracter>> <> resto, numero, lista ) do
    if esNumero?(<<caracter>>) do
      listar(resto, numero <> <<caracter>>, lista)
    else
      listar(resto, "", [{String.to_integer(numero), <<caracter>>} | lista] )
    end
  end

  def esNumero?(caracter) do
    cond do
      caracter in @numeros -> true
      true -> false
    end
  end
end
