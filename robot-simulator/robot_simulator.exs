defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """

  @valid [:north, :east, :south, :west]
  @spec create(direction :: atom, position :: { integer, integer }) :: any
  def create(direction \\ :north, position \\ {0, 0})  do
    pcreate(direction, position)
  end

  defp pcreate(direction, {x, y}) when direction in @valid and is_integer(x) and is_integer(y) do
    {direction, {x, y}}
  end

  defp pcreate(direction, _position) do
    cond do
      direction in @valid == false -> {:error, "invalid direction"}
      true -> {:error, "invalid position"}
    end
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t ) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.graphemes
    |> move_robot(robot)
  end

  defp move_robot([], robot) do
    robot
  end

  defp move_robot([h | t], robot) do
    case h do
      "A" -> move_robot(t, advance(robot))
      "R" -> move_robot(t, move_right(robot))
      "L" -> move_robot(t, move_left(robot))
      _ -> {:error, "invalid instruction"}
    end
  end

  defp move_right({direction, {x, y}}) do
    case direction do
      :north -> {:east, {x, y}}
      :south -> {:west, {x, y}}
      :east -> {:south, {x, y}}
      :west ->{:north, {x, y}}
    end
  end

  defp move_left({direction, {x, y}}) do
    case direction do
      :north -> {:west, {x, y}}
      :south -> {:east, {x, y}}
      :east -> {:north, {x, y}}
      :west ->{:south, {x, y}}
    end
  end

  defp advance({direction, {x, y}}) do
    case direction do
      :north -> {direction, {x, y + 1}}
      :south -> {direction, {x, y - 1}}
      :east -> {direction, {x + 1, y}}
      :west  -> {direction, {x - 1, y}}
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({direction, _position}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: { integer, integer }
  def position({_direction, position}) do
    position
  end
end
