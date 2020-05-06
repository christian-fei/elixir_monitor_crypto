defmodule ElixirMonitorCrypto.Behaviours.ApiClient do
  @callback get_latest_quote(any(), any()) :: any()
end
