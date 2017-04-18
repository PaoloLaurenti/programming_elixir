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

  def start do
    pid = spawn(__MODULE__, :generator, [])
    register_diamond_master(pid)
    send :global.whereis_name(@master_name), {:register, pid}
  end

  def register_diamond_master(pid) do
    :global.register_name(@master_name, pid)
  end

  def generator do
    master_pid = :global.whereis_name(@master_name)
    receive do
      {:register, pid} when pid === master_pid === self() ->
        generator()
    end
  end
end
