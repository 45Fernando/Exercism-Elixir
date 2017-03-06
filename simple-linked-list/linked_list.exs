defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    []
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    [elem | list]
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length(list) do
    plength(list,0)
  end

  defp plength([], acc) do
    acc
  end

  defp plength([_h | t], acc) do
    plength(t, acc+1)
  end

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?([]) do
    true
  end

  def empty?([_ | _]) do
    false
  end

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek([]) do
    {:error, :empty_list}
  end

  def peek([h | _t]) do
    {:ok, h}
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail([]) do
    {:error, :empty_list}
  end

  def tail([_h | t]) do
    {:ok, t}
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop([]) do
    {:error, :empty_list}
  end

  def pop([h | t]) do
    {:ok, h, t}
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    list
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
      preverse(list, [])
  end

  defp preverse([h], nuevaLista) do
    LinkedList.push(nuevaLista, h)
  end

  defp preverse([h | t], nuevaLista) do
    nuevaLista = LinkedList.push(nuevaLista, h)
    preverse(t, nuevaLista)
  end
end
