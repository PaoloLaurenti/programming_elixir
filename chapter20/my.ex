defmodule My do

  defmacro unless(condition, clauses) do
    do_clause = Keyword.get(clauses, :do)
    else_clause = Keyword.get(clauses, :else)

    quote do
      case unquote(condition) do
        val when val in [nil, false] -> unquote(do_clause)
        _ -> unquote(else_clause)
      end
    end
  end

end

defmodule Test do
  require My

  My.unless 1 !== 2 do
    IO.puts "PRINT ERROR"
  else
    IO.puts "PRINT OK"
  end

  IO.puts ""
  IO.puts "=============="
  IO.puts ""

  My.unless 1 === 2 do
    IO.puts "PRINT OK"
  else
    IO.puts "PRINT ERROR"
  end
end
