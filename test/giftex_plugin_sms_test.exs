defmodule GiftexPluginSmsTest do
  @behaviour GiftexPlugin

  use ExUnit.Case

  def exec(config, giver, receiver) do
    send(self(), {:test_sms, config["sms_gateway"], giver, receiver})
    :ok
  end

  @doc """
  Assert that metadata has been sent by invoking exec/1.
  """
  def assert_sent(giver, receiver) do
    assert_receive {:test_sms, "sms://message.com/gw", giver, receiver}
  end
end
