defmodule NervesElixir.Worker do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: NervesElixir.Worker)
  end

  def get_value do
    GenServer.call(NervesElixir.Worker, :get_value)
  end

  def init(_args) do
    {:ok, 0}
  end

  def handle_call(:get_value, _from, value) do
    {:reply, value, value+1}
  end

end

