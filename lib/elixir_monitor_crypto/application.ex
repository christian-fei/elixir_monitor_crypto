defmodule ElixirMonitorCrypto.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Supervisor.child_spec({CoinbasePro.WebsocketFeed, ["heartbeat"]}, id: :heartbeat),
      Supervisor.child_spec({CoinbasePro.WebsocketFeed, ["ticker"]}, id: :ticker),
      Supervisor.child_spec({CoinbasePro.WebsocketFeed, ["status"]}, id: :status),
      Supervisor.child_spec({CoinbasePro.WebsocketFeed, ["level2"]}, id: :level2)
    ]
    opts = [strategy: :one_for_one, name: ElixirMonitorCrypto.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
