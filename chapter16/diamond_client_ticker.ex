#Exercise: Nodes-4
#The ticker process in this chapter is a central server that sends events to
#registered clients. Reimplement this as a ring of clients. A client sends a
#tick to the next client in the ring. After 2 seconds, that client sends a tick
#to its next client. When thinking about how to add clients to the ring,
#remember to deal with the case where a client’s receive loop times out just as
#you’re adding a new process. What does this say about who has to be responsible
#for updating the links?

defmodule DiamondClientTicker do

  @master_name :diamond_master
  @timeout 3000

  def start do
    pid = spawn(__MODULE__, :generator, [])
    register_diamond_master(pid)
    send pid, {:start}
    send :global.whereis_name(@master_name), {:register, pid}
  end

  def register_diamond_master(pid) do
    :global.register_name(@master_name, pid)
  end

  def generator(next_pid \\ self(), master_pid \\ self()) do
    receive do
      {:start} ->
        master_pid = :global.whereis_name(@master_name)
        generator(next_pid, master_pid)
      {:register, pid} when pid === master_pid ->
        IO.puts "Still all alone..."
        generator()
      {:register, pid} when next_pid === master_pid ->
        IO.puts "I am the last one, sending :set_next request to #{inspect pid}"
        send pid, {:set_next, self(), master_pid}
        generator(next_pid, master_pid)
      {:register, pid} ->
        IO.puts "Pass through, I am not the last one..."
        send next_pid, {:register, pid}
        generator(next_pid, master_pid)
      {:set_next, source_pid, pid_to_set} ->
        IO.puts ":set_next request received from #{inspect source_pid} for pid #{inspect pid_to_set}"
        send source_pid, {:set_next_completed, self()}
        generator(pid_to_set, master_pid)
      {:set_next_completed, pid} ->
        IO.puts ":set_next_completed response received from pid #{inspect pid}"
        generator(pid, master_pid)
      {:tick, source_pid} ->
        IO.puts "tock in client, tick sent from #{inspect source_pid}"
        generator(next_pid, master_pid)
    after @timeout ->
        if (next_pid !== self()) do
          IO.puts "tick to #{inspect next_pid}"
          send next_pid, {:tick, self()}
        end
      generator(next_pid, master_pid)
    end
  end
end
