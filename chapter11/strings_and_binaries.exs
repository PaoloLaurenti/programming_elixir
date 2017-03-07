defmodule StringsAndBinaries do

  #############################################################################
  # Exercise: StringsAndBinaries-1
  # Write a function that returns true if single-quoted string contains only printable ASCII characters (space through tilde).
  ############################################################################

  def is_printable(string) when is_list(string) do
    Enum.all?(string, &(&1 >= 32 && &1 <= 126))
  end

  ############################################################################
end
