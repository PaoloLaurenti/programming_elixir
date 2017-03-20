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

  #############################################################################
  # Exercise: ControlFlow-2
  # Many built-in functions have two forms. The xxx form returns the tuple
  # {:ok, data} and the xxx! form returns data on success but raises an exception
  # otherwise. However, some functions don’t have the xxx! form. Write an ok!
  # function that takes an arbitrary parameter. If the parameter is the tuple
  # {:ok, data} , return the data. Otherwise, raise an exception containing
  # information from the parameter.
  #############################################################################

  def ok!({:ok, data}), do: data
  def ok!({:error, message}), do: raise to_string(message)
  def ok!(_), do: raise "unknown parameter"

  #############################################################################

end
