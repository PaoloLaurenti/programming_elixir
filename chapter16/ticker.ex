#---
# Excerpted from "Programming Elixir 1.3",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/elixir13 for more book information.
#---

defmodule Ticker do

  @interval 2000   # 2 seconds
  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[], []])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients_to_process, processed_clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        generator(clients_to_process ++ [pid], processed_clients)
    after
      @interval ->
        tick(clients_to_process, processed_clients)
    end
  end

  defp tick([], []), do: generator([], [])
  defp tick([], processed_clients), do: tick(Enum.reverse(processed_clients), [])
  defp tick([next_client|clients_to_process], processed_clients) do
    IO.puts "tick"
    send next_client, { :tick }
    generator(clients_to_process, [next_client|processed_clients])
  end
end
