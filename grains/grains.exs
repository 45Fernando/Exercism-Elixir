defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number < 1 or number > 64 do
    { :error, "The requested square must be between 1 and 64 (inclusive)" }
  end

  def square(1) do
    {:ok, 1}
  end

  def square(number) do
    value = 1..number-1
            |> Enum.reduce(0, fn(x, acc) -> x * 2 + acc end)

    {:ok, value}
  end

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    sum = 1..64
          |> Stream.map(fn(x) ->
                {:ok, value} = square(x)
                value
              end)
          |> Enum.sum

    {:ok, sum}
  end
end
