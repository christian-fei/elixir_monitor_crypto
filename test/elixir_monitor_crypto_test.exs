defmodule ElixirMonitorCryptoTest do
  use ExUnit.Case
  import Mox
  setup :verify_on_exit!

  test "gets quotes for single symbol" do
    expect(ApiClientMock, :get_latest_quote, fn _,_ -> btc_quote() end)

    btc_quote = Coinmarketcap.Client.get_latest_quote("BTC")

    assert Map.get(btc_quote, "max_supply") == 21000000
  end


  defp btc_quote do
    %{
      "max_supply" => 21000000
    }
  end
end
