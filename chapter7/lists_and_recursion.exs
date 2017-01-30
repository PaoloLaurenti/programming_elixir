defmodule ListsAndRecursion do

  #############################################################################
  # Exercise: ListsAndRecursion-0
  # I defined our sum function to carry a partial total as a second parameter so I could illustrate how to use accumulators to build values.
  # The sum function can also be written without an accumulator. Can you do it?
  def sum(list), do: _sum(list, 0)

  defp _sum([], total), do: total
  defp _sum([head | tail], total), do: _sum(tail, head + total)

  def sum_no_acc([]), do: 0
  def sum_no_acc([head | tail]), do: head + sum_no_acc(tail)
  #############################################################################

  #############################################################################
  # Exercise: ListsAndRecursion-1
  # Write a mapsum function that takes a list and a function. It applies the function to each element of the list and then sums the result
  def mapsum(list, function), do: _mapsum(list, function, 0)

  defp _mapsum([], _, total), do: total
  defp _mapsum([head | tail], function, total), do: _mapsum(tail, function, total + function.(head))
  #############################################################################

  #############################################################################
  # Exercise: ListsAndRecursion-2
  # Write a max(list) that returns the element with the maximum value in the list
  def max([head | _tail] = list), do: _max(list, head)

  defp _max([], max_result), do: max_result
  defp _max([head | tail], current_max) do
    if current_max >= head do
      _max(tail, current_max)
    else
      _max(tail, head)
    end
  end
  #############################################################################

  #############################################################################
  # Exercise: ListsAndRecursion-3
  # An Elixir single-quoted string is actually a list of individual character codes.
  # Write a caesar(list, n) function that adds n to each list element, wrapping if the addition results in a character greater than z
  def caesar(list, n), do: _caesar(list, n, [])

  defp _caesar([], _, result), do: Enum.reverse(result)
  defp _caesar([head | tail], n, result) when head + n <= ?z do
    _caesar(tail, n, [head + n | result])
  end
  defp _caesar([head | tail], n, result) do
    _caesar(tail, n, [head + n - 26 | result])
  end
  #############################################################################

  #############################################################################
  # Exercise: ListsAndRecursion-4
  # Write a function MyList.span(from, to) that returns a list of the numbers from from up to to
  def span(from, to) when from > to, do: raise "From parameter must be smaller than to parameter"
  def span(from, to), do: _span(from, to, [])

  defp _span(to, to, result), do: [to | result] |> Enum.reverse
  defp _span(from, to, partial_result), do: _span(from + 1, to, [from | partial_result])
  #############################################################################

  #############################################################################
  # Exercise: ListsAndRecursion-5
  # Implement the following Enum functions using no library functions or list comprehensions

  #all?
  def all?(enumerable, fun \\ fn x -> x end), do: _all?(enumerable, fun, true)

  defp _all?(_enumerable, _fun, false), do: false
  defp _all?([], _fun, result), do: result
  defp _all?([head | tail], fun, partial_result), do: _all?(tail, fun, partial_result && to_bool(fun.(head)))

  defp to_bool(value), do: !!value

  #----------------------------------------------------------------------------

  #each
  def each(enumerable, fun), do: _each(enumerable, fun, [])

  defp _each([], _fun, result), do: Enum.reverse(result)
  defp _each([head | tail], fun, partial_result), do: _each(tail, fun, [fun.(head) | partial_result])

  #----------------------------------------------------------------------------

  #filter
  def filter(enumerable, fun), do: _filter(enumerable, fun, [])

  defp _filter([], _fun, result), do: Enum.reverse(result)
  defp _filter([head | tail], fun, partial_result) do
    if fun.(head) do
      _filter(tail, fun, [head | partial_result])
    else
      _filter(tail, fun, partial_result)
    end
  end

  #----------------------------------------------------------------------------

  #############################################################################

end
