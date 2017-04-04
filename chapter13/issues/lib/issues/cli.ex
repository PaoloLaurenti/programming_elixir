#---
## Excerpted from "Programming Elixir 1.3",
## published by The Pragmatic Bookshelf.
## Copyrights apply to this code. It may not be used to create training
#material,
## courses, books, articles, and the like. Contact us if you are in doubt.
## We make no guarantees that this code is fit for any purpose.
## Visit http://www.pragmaticprogrammer.com/titles/elixir13 for more book
#information.
##---
defmodule Issues.CLI do

  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to
  the various functions that end up generating a
  table of the last _n_ issues in a github project
  """

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github user name, project name, and (optionally)
  the number of entries to format.

  Return a tuple of `{ user, project, count }`, or `:help` if help was given.
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help: :boolean],
                               aliases:  [ h:    :help   ])
    case  parse  do

      { [ help: true ], _, _ }
      -> :help

      { _, [ user, project, count ], _ }
      -> { user, project, String.to_integer(count) }

      { _, [ user, project ], _ }
      -> { user, project, @default_count }

      _ -> :help

    end
  end

  def process({user, project, count}) do
    issues = Issues.GithubIssues.fetch(user, project)
    |> decode_response
    |> sort_into_ascending_order
    |> Enum.take(count)

    IO.puts build_report_for(issues)
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from GitHub: #{message}"
    System.halt(2)
  end

  def sort_into_ascending_order(list_of_issues) do
    Enum.sort list_of_issues, fn(i1, i2) ->
      Map.get(i1, "created_at") <= Map.get(i2, "created_at")
    end
  end

  def build_report_for(issues) do
    report_body = Enum.map(issues, &to_report_row/1)
    header =    " #        | created_at         |  title                 "
    separator = "----------+--------------------+------------------------"
    Enum.join([header | [separator | report_body]], "\n")
  end

  def to_report_row(issue) do
    id = Map.get(issue, "id") |> Integer.to_string |>String.pad_leading(10)
    created_at = Map.get(issue, "created_at")
    title = Map.get(issue, "title")
    "#{id}|#{created_at}|#{title}"
  end

end
