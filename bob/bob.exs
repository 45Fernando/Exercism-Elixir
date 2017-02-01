defmodule Bob do
  def hey(input) do
    cond do
        String.trim(input) == "" -> "Fine. Be that way!"
        String.ends_with?(input, "?") -> "Sure."
        input == String.upcase(input) && soloNumeros(input) == false -> "Whoa, chill out!"
        true -> "Whatever."
    end
  end

  def soloNumeros(input) do
    input
    |>String.split(",")
    |>Stream.map(&String.trim/1)
    |>Enum.map(&convertir/1)
    |>Enum.all?(&is_number/1)
  end

  def convertir(caracter) do
    case caracter do
      "0" -> 0
      "1" -> 1
      "2" -> 2
      "3" -> 3
      "4" -> 4
      "5" -> 5
      "6" -> 6
      "7" -> 7
      "8" -> 8
      "9" -> 9
      _ -> caracter
    end
  end

end
