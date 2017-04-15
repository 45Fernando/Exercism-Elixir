defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date

  def meetup(year, month, weekday, :teenth) do
    case weekday do
      :monday -> calculate(year,month, 1, 13)
      :tuesday -> calculate(year,month, 2, 13)
      :wednesday -> calculate(year,month, 3, 13)
      :thursday -> calculate(year,month, 4, 13)
      :friday -> calculate(year,month, 5, 13)
      :saturday -> calculate(year,month, 6, 13)
      :sunday -> calculate(year,month, 7, 13)
    end
  end

  def meetup(year, month, weekday, schedule) do
    {year, month, day} = case weekday do
                            :monday -> calculate(year,month, 1, 1)
                            :tuesday -> calculate(year,month, 2, 1)
                            :wednesday -> calculate(year,month, 3, 1)
                            :thursday -> calculate(year,month, 4, 1)
                            :friday -> calculate(year,month, 5, 1)
                            :saturday -> calculate(year,month, 6, 1)
                            :sunday -> calculate(year,month, 7, 1)
                          end
    case schedule do
      :first -> {year, month, day}
      :second -> {year, month, day + 7}
      :third -> {year, month, day + 14}
      :fourth -> {year, month, day + 21}
      :last -> check(year, month, day + 28)
    end
  end


  defp calculate(year, month, dayofweek, day) do
    {:ok, date} = Date.new(year, month, day)
    cond do
      dayofweek == Date.day_of_week(date) -> {year, month, day}
      true -> calculate(year, month, dayofweek, day + 1)
    end
  end

  defp check(year,month,day) do
    case Date.new(year, month, day) do
      {:ok, _} -> {year, month, day}
      {:error, _} -> {year, month, day - 7}
    end
  end
end
