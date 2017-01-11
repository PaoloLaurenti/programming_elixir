defmodule ListsAndRecursion do

  def sum(list), do: _sum(list, 0)

  defp _sum([], total), do: total
  defp _sum([head | tail], total), do: _sum(tail, head + total)

  def sum_no_acc([]), do: 0
  def sum_no_acc([head | tail]), do: head + sum_no_acc(tail)
end
