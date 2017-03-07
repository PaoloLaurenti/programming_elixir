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
end
