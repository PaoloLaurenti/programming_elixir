defmodule Processes do
  def go do
    first_pid = spawn(fn ->
        send_back()
    end)

    second_pid = spawn(Processes, :send_back, [])

    send first_pid, {self(), "fred"}
    send second_pid, {self(), "betty"}

    receive do
      token -> IO.puts "Token received: " <> token
    end

    receive do
      token -> IO.puts "Token received: " <> token
    end

  end

  def send_back() do
      receive do
        {source, token} when is_binary(token) ->
          send source, token
      end
  end
end
