defmodule Stack.Application do
  use Application

  def start(_type, _args) do
    {:ok, _pid} = Stack.Supervisor.start_link([1, "two", :three])
  end
end
