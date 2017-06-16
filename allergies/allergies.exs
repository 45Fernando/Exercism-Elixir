defmodule Allergies do
  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @allergies ["eggs", "peanuts", "shellfish", "strawberries", "tomatoes",
              "chocolate", "pollen", "cats"]

  @spec list(non_neg_integer) :: [String.t]
  def list(0), do: []
  def list(flags) do
    flags
    |> Integer.digits(2)
    |> Enum.reverse
    |> Stream.zip(@allergies)
    |> Stream.reject(fn({bit, _allergie})-> bit == 0 end)
    |> Enum.map(fn({_bit, allergie})-> allergie end)
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to(0, _), do: false
  def allergic_to?(flags, item) do
    flags
    |> list
    |> Enum.any?(&(&1) == item)
  end
end
