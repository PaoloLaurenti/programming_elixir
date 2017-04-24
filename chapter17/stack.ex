defmodule Stack do
  use GenServer

  def handle_call({:pop}, _from, [head | stack]) do
    {:reply, head, stack}
  end

  def handle_cast({:push, value}, state) do
    {:noreply, [value | state]}
  end

end
