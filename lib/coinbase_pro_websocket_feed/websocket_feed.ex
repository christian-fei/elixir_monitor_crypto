defmodule CoinbasePro.WebsocketFeed do
  use WebSockex

  def start_link(state) do
    {:ok, pid} = WebSockex.start_link("wss://ws-feed.pro.coinbase.com", __MODULE__, state)
    init(pid)
    {:ok, pid}
  end

  defp init (pid) do
    msg = Poison.encode!(%{
      type: "subscribe",
      product_ids: ["BTC-EUR"],
      channels: ["heartbeat", "ticker", "status", "level2"]
    })
    WebSockex.send_frame(pid, {:text, msg})
  end

  def handle_msg(msg, state) do
    IO.puts("handle_msg #{Poison.encode(msg)}")
    {:ok, state}
  end

  def handle_connect(_conn, state) do
    IO.puts("Connected!")
    {:ok, state}
  end

  def handle_disconnect(%{reason: {:local, reason}}, state) do
    IO.puts("Local close with reason: #{inspect reason}")
    {:ok, state}
  end

  def handle_disconnect(disconnect_map, state) do
    super(disconnect_map, state)
  end

  def handle_frame({type, msg}, state) do
    IO.puts "Received Message - Type: #{inspect type} -- Message: #{inspect msg}"
    {:ok, state}
  end

  def handle_cast({:send, {type, msg} = frame}, state) do
    IO.puts "Sending #{type} frame with payload: #{msg}"
    {:reply, frame, state}
  end
end


