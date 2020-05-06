defmodule Coinmarketcap.ApiClient do
  @behaviour ElixirMonitorCrypto.Behaviours.ApiClient
  use HTTPoison.Base

  @api_base_url "https://pro-api.coinmarketcap.com"
  @api_key System.get_env("COINMARKETCAP_API_KEY")
  @headers ["X-CMC_PRO_API_KEY": @api_key, "Accept": "application/json; charset=utf-8"]

  def get_latest_quote(symbol, convert \\ "EUR") do
    endpoint = "/v1/cryptocurrency/quotes/latest"
    query_params = "?symbol=#{symbol}&convert=#{convert}"
    url = @api_base_url <> endpoint <> query_params

    get(url, @headers)
    |> handle_response
    |> Map.get(symbol)
  end

  defp handle_response(resp) do
    case resp do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body)
        |> Map.get("data")
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts "Not found"
      {:ok, %HTTPoison.Response{status_code: 401}} ->
        IO.puts "Unauthorized"
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect reason
    end
  end

end
