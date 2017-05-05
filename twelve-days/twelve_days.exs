defmodule TwelveDays do
  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """

  @numbers %{1 => {"first", "a Partridge"}, 2 => {"second", "two Turtle Doves, and "}, 3 => {"third", "three French Hens, "}, 4 => {"fourth", "four Calling Birds, "},
            5 => {"fifth", "five Gold Rings, "}, 6 => {"sixth", "six Geese-a-Laying, "}, 7 => {"seventh", "seven Swans-a-Swimming, "} ,8 => {"eighth", "eight Maids-a-Milking, "},
            9 => {"ninth", "nine Ladies Dancing, "}, 10 => {"tenth", "ten Lords-a-Leaping, "}, 11 => {"eleventh", "eleven Pipers Piping, "}, 12 => {"twelfth", "twelve Drummers Drumming, "}}

  @spec verse(number :: integer) :: String.t()
  def verse(number) do
    gifts = gifth(number, "")
    dayth(number, gifts)
  end

  defp dayth(number, gifts) do
    {day,_} = Map.get(@numbers, number)
    "On the "<> day <>" day of Christmas my true love gave to me, "<>gifts<> " in a Pear Tree."
  end

  defp gifth(1, string) do
    string <> "a Partridge"
  end

  defp gifth(number, string) do
     {_, gift} = Map.get(@numbers, number)
     gifth(number - 1, string <> gift)
  end

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
    |> Stream.map(&verse/1)
    |> Enum.join("\n")
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses(1, 12)
  end
end