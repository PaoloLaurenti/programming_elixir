defmodule Stack do
  use GenServer

  def start_link(list) do
    GenServer.start_link(__MODULE__, list, name: __MODULE__)
  end

  def pop() do
    GenServer.call __MODULE__, :pop
  end

  def push(value) do
    GenServer.cast __MODULE__, {:push, value}
  end

  def handle_call(:pop, _from, [head | stack]) do
    {:reply, head, stack}
  end

  def handle_cast({:push, value}, state) do
    {:noreply, [value | state]}
  end

  def terminate(reason, state) do
    IO.puts "Reason ==> #{inspect reason}"
    IO.puts "State ==> #{inspect state}"
  end
end
