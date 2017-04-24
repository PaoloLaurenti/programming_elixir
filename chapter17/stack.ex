defmodule Stack do
  use GenServer

  def handle_call({:pop}, _from, [head | stack]) do
    {:reply, head, stack}
  end

end
