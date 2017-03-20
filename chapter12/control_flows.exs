defmodule ControlFlows do

  #############################################################################
  # Exercise: ControlFlow-1
  # Rewrite the FizzBuzz example using case
  #############################################################################

  def fizz_buzz(range) do
    Enum.map(range, &convert/1)
  end

  def convert(number) do
    case {rem(number, 3), rem(number, 5)} do
      {0, 0} -> "FizzBuzz"
      {0, _} -> "Fizz"
      {_, 0} -> "Buzz"
      _ -> number
    end
  end

  #############################################################################

end
