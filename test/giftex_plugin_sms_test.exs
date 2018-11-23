defmodule GiftexPluginSmsTest do
  @behaviour GiftexPlugin

  use ExUnit.Case

  def exec(meta) do
    send(self(), {:test_sms, meta})
    :ok
  end

  @doc """
  Assert that metadata has been sent by invoking exec/1.
  """
  def assert_sent(meta) do
    assert_receive {:test_sms, meta}
  end
end
