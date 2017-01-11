defmodule ListsAndRecursion do

  def sum(list), do: _sum(list, 0)

  defp _sum([], total), do: total
  defp _sum([head | tail], total), do: _sum(tail, head + total)

  def sum_no_acc([]), do: 0
  def sum_no_acc([head | tail]), do: head + sum_no_acc(tail)

  def mapsum(list, function), do: _mapsum(list, function, 0)

  defp _mapsum([], _, total), do: total
  defp _mapsum([head | tail], function, total), do: _mapsum(tail, function, total + function.(head))

  def max([head | tail] = list), do: _max(list, head)

  defp _max([], max_result), do: max_result
  defp _max([head | tail], current_max) do
    if current_max >= head do
      _max(tail, current_max)
    else
      _max(tail, head)
    end
  end

  def caesar(list, n), do: _caesar(list, n, [])

  defp _caesar([], _, result), do: Enum.reverse(result) 
  defp _caesar([head | tail], n, result) when head + n <= ?z do
    _caesar(tail, n, [head + n | result])
  end
  defp _caesar([head | tail], n, result) do
    _caesar(tail, n, [head + n - 26 | result])
  end
end
