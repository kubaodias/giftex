defmodule GiftexPluginMailTest do
  @behaviour GiftexPlugin

  use ExUnit.Case

  def exec(config, giver, receiver) do
    send(self(), {:test_mail, config["smtp_server"], giver, receiver})
    :ok
  end

  @doc """
  Assert that metadata has been sent by invoking exec/1.
  """
  def assert_sent(giver, receiver) do
    assert_receive {:test_mail, "10.0.0.10:465", giver, receiver}
  end
end
