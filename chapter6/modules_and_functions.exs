defmodule ModulesAndFunctions do
  def sum(1) do
    1
  end

  def sum(n) do
    n + sum(n-1)
  end

  def gcd(x,0) do
    x
  end

  def gcd(x, y) do
    gcd(y, rem(x, y))
  end

  def convert_float_to_string(value) do
    :io_lib.format("~.2f", [value])
      |> List.flatten
  end

  def get_environment_variable(variable_name) do
    System.get_env(variable_name)
  end

  def get_file_extension(file_path) do
    Path.extname(file_path)
  end

  def get_current_woring_directory() do
    System.cwd()
  end

end
