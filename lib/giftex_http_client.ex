defmodule GiftexHttpClient do
  @moduledoc """
  Documentation for GiftexHttpClient.
  """
  @callback post(binary(), list()) :: :ok | :error

end
