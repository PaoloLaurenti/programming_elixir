defmodule ListsAndRecursion do

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

  #split
  def split(enumerable, count) when count >= 0, do: _split(enumerable, count, [])
  def split(enumerable, count), do: _split(Enum.reverse(enumerable), count, [], :backward)

  defp _split(remaining_part, 0, splitted_part), do: { Enum.reverse(splitted_part), remaining_part }
  defp _split([], _count, splitted_part), do: _split([], 0, splitted_part)
  defp _split([head | tail], count, partial_splitted_part) when count > 0, do: _split(tail, count - 1, [head | partial_splitted_part])

  defp _split(remaining_part, 0, splitted_part, :backward), do: { Enum.reverse(remaining_part), splitted_part }
  defp _split([], _count, splitted_part, :backward), do: _split([], 0, splitted_part, :backward)
  defp _split([head | tail], count, partial_splitted_part, :backward), do: _split(tail, count + 1, [head | partial_splitted_part], :backward)

  #----------------------------------------------------------------------------

  #take
  def take(enumerable, count) when count < 0, do: Enum.reverse(_take(Enum.reverse(enumerable), count * -1, []))
  def take(enumerable, count), do: _take(enumerable, count, [])

  defp _take([], _count, result), do: Enum.reverse(result)
  defp _take(_enumerable, 0, result), do: _take([], 0, result)
  defp _take([head | tail], count, partial_result), do: _take(tail, count - 1, [head | partial_result])

  #############################################################################

  #############################################################################
  # Exercise: ListsAndRecursion-6
  # Write a flatten(list) function that takes a list that may contain any number of sublists, which themselves may contain sublists, to any depth. It returns the elements of these lists as a flat list.
  def flatten(array) when is_list(array) do
    flatten(array, [])
      |> Enum.reverse
  end

  defp flatten(array, result) when is_list(array) do
    Enum.reduce(array, result, &flatten/2)
  end

  defp flatten(value, result) when is_integer(value) do
    [value | result]
  end
  #############################################################################

  #############################################################################
  # Exercise: ListsAndRecursion-7
  # In the last exercise of Chapter 7, Lists and Recursion , you
  # wrote a span function. Use it and list comprehensions to return a list of
  # the prime numbers from 2 to n.

  #defp is_prime(number), do: is_prime(number, 2)
  #defp is_prime(number, number), do: true
  #defp is_prime(number, divisor) when rem(number, divisor) == 0, do: is_prime(number, divisor + 1)

  def span2(from, to) do
    for n <- from..to, is_prime(n), do: n
  end

  def is_prime(2), do: true
  def is_prime(number) when number > 2 do
    2..number-1
    |> Enum.reduce_while(true, fn(n, acc) ->
      if (rem(number, n)) == 0 do
        {:halt, false}
      else
        {:cont, acc}
      end
    end)
  end

end
