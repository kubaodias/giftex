defmodule GiftexPluginMailTest do
  @behaviour GiftexPlugin

  use ExUnit.Case

  def exec(meta) do
    send(self(), {:test_mail, meta})
    :ok
  end

  @doc """
  Assert that metadata has been sent by invoking exec/1.
  """
  def assert_sent(meta) do
    assert_receive {:test_mail, meta}
  end
end
