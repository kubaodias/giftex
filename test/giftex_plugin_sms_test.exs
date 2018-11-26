defmodule GiftexPluginSmsTest do
  @behaviour GiftexPlugin

  use ExUnit.Case

  def exec(from, to) do
    sms_meta = from.plugins_meta["test_sms"]
    send(self(), {:test_sms, sms_meta, from, to})
    :ok
  end

  @doc """
  Assert that metadata has been sent by invoking exec/1.
  """
  def assert_sent(from, to) do
    sms_meta = from.plugins_meta["test_sms"]
    assert_receive {:test_sms, sms_meta, from, to}
  end
end
