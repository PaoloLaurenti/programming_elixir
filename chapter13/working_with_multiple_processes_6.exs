defmodule WorkingWithMultipleProcesses6 do
  def run do
    Process.flag(:trap_exit, true)
    {pid, _} = spawn_monitor(WorkingWithMultipleProcesses6, :send_back, [])
    send pid, {self(), "62"}
    :timer.sleep(500)

    receive_msgs()
  end

  def receive_msgs do
    receive do
      message ->
        IO.puts inspect message
        receive_msgs()
    end
  end

  def send_back do
    receive do
      {sender, message} ->
        send sender, message
        raise "terrible error"
    end
  end
end

WorkingWithMultipleProcesses6.run
