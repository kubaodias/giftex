defmodule GiftexPluginMailTest do
  @behaviour GiftexPlugin

  use ExUnit.Case

  def exec(from, to) do
    mail_meta = from.plugins_meta["test_mail"]
    send(self(), {:test_mail, mail_meta, from, to})
    :ok
  end

  @doc """
  Assert that metadata has been sent by invoking exec/1.
  """
  def assert_sent(from, to) do
    mail_meta = from.plugins_meta["test_mail"]
    assert_receive {:test_mail, mail_meta, from, to}
  end
end
