defmodule WorkingWithMultipleProcesses4 do
  def run do
    Process.flag(:trap_exit, true)
    pid = spawn_link(WorkingWithMultipleProcesses4, :send_back, [])
    send pid, {self(), "42"}
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

WorkingWithMultipleProcesses4.run
