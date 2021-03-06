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

  ############################################################################
  # Exercise: StringsAndBinaries-5
  # Write a function that takes a list of dqs and prints each on a separate line,
  # centered in a column that has the width of the longest string.
  # Make sure it works with UTF characters.
  ############################################################################

  def print_centered(strings) do
    max_length =
      Enum.map(strings, &(String.length(&1)))
      |> Enum.max()
    print_centered(strings, max_length)
  end

  defp print_centered([], _) do
  end

  defp print_centered([string | other_strings], max_length) do
    string_length = String.length string
    spaces_count = max_length - string_length
    leading_spaces_count = div spaces_count, 2
    trailing_spaces_count = round(spaces_count/2)
    output = String.pad_leading(string, leading_spaces_count + string_length, " ") |> String.pad_trailing(trailing_spaces_count + string_length, " ")
    IO.puts output
    print_centered(other_strings, max_length)
  end

  ############################################################################

  ############################################################################
  # Exercise: StringsAndBinaries-6
  # Write a function to capitalize the sentences in a string.
  # Each sentence is terminated by a period and a space.
  # Right now, the case of the characters in the string is random
  ############################################################################

  def capitalize_senteces(string) do
    senteces = String.split(string, ". ", trim: true)
    result = Enum.map(senteces, &(String.capitalize(&1) <> ". ")) |> List.to_string
    IO.puts result
  end

  ############################################################################


  ############################################################################
  # Exercise: StringsAndBinaries-7
  # Write a function that reads and parses this file and then passes the result to the sales_tax function.
  # Remember that the data should be formatted into a keyword list, and that the fields need to be the correct types
  # (so the id field is an integer, and so on).
  ############################################################################

  def get_total_amount(sale_information_file_path) do
    {:ok, file} = File.open(sale_information_file_path, [:read, :binary, :utf8])
    orders =
      IO.stream(file, :line)
      |> Stream.drop(1)
      |> Stream.map(&entry_to_keyword_list/1)
      |> Enum.to_list
    File.close(file)
    #IO.inspect orders
    sales_tax(orders)
  end

  defp entry_to_keyword_list(entry) do
    entry = String.trim_trailing(entry, "\n")
    [id, ship_to, net_amount] = String.split(entry, ",")
    [id: String.to_integer(id), ship_to: String.to_atom(String.trim_leading(ship_to, ":")), net_amount: String.to_float(net_amount)]
  end

  defp sales_tax(orders) do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    for o <- orders do
      tax = tax_rates[o[:ship_to]] || 0
      total_amount = Float.round(o[:net_amount] + tax, 3)
      Keyword.put(o, :total_amount, total_amount)
    end
  end

  ############################################################################

end
