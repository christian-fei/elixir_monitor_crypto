defmodule Coinmarketcap.Client do
  @api_client Application.fetch_env!(:elixir_monitor_crypto, :api_client)
  def get_latest_quote(symbol, convert \\ "EUR") do
    @api_client.get_latest_quote(symbol, convert)
  end
end
