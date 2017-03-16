defmodule StringsAndBinaries do

  #############################################################################
  # Exercise: StringsAndBinaries-1
  # Write a function that returns true if single-quoted string contains only
  # printable ASCII characters (space through tilde).
  ############################################################################

  def is_printable?(string) when is_list(string) do
    Enum.all?(string, &(&1 >= 32 && &1 <= 126))
  end

  ############################################################################

  ############################################################################
  # Exercise: StringsAndBinaries-2
  # Write an anagram?(word1, word2) that returns true if its parameters are
  # anagrams.
  ############################################################################

  def anagram?(word1, word2) do
    Enum.count(word1) === Enum.count(word2) and not Enum.any?(word1, fn(character) -> not Enum.any?(word2, &(&1 == character)) end)
  end

  ############################################################################

  ############################################################################
  # Exercise: StringsAndBinaries-4
  # (Hard) Write a function that takes a single-quoted string of the form number
  # [+-*/] number and returns the result of the calculation. The individual
  # numbers do not have leading plus or minus signs.
  # calculate(’123 + 27’) # => 150
  ############################################################################

  def calculate(expression) do
    [number1, operator, number2] = Enum.chunk_by(expression, &(&1 == 32)) |> Enum.filter(&(&1 != [32])) |> Enum.map(&single_quoted_string_to_number/1)
    calculate(number1, operator, number2)
  end

  defp single_quoted_string_to_number([operator_string]) when operator_string < 48 or operator_string > 57, do: operator_string
  defp single_quoted_string_to_number(number_string) do
    {result, _} = Enum.reverse(number_string)
    |> Enum.reduce({0, 1}, fn(digit, {partial_result, current_index}) ->
      new_partial_result = partial_result + ((digit - ?0) * current_index)
      {new_partial_result, current_index * 10}
    end)
    result
  end

  defp calculate(number1, ?+, number2), do: number1 + number2
  defp calculate(number1, ?-, number2), do: number1 - number2
  defp calculate(number1, ?*, number2), do: number1 * number2
  defp calculate(number1, ?/, number2), do: number1 / number2

  ############################################################################
end
