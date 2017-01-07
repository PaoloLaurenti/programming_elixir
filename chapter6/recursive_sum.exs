defmodule RecursiveSum do
  def of(1) do
    1
  end

  def of(n) do
    n + of(n-1)
  end
end
