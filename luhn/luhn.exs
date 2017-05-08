defmodule Luhn do
  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    number
    |> String.to_integer
    |> Integer.digits
    |> Enum.reverse
    |> double(0)
    |> Enum.sum
  end

  defp double([], _p) do
    []
  end

  defp double([h | t], 0) do
    [h | double(t,1)]
  end

  defp double([h | t], 1) do
    h = if h*2 > 9 do
          h*2 - 9
        else
          h*2
        end

    [h | double(t,0)]
  end
  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    number = number
             |> checksum

    case rem(number, 10) do
       0 -> true
       _ -> false
    end
  end



  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    0..9
    |> Enum.map(fn(x)-> number <> Integer.to_string(x) end)
    |> Enum.find(&valid?(&1))
  end
end
