defmodule GiftexPluginTest do
  use ExUnit.Case
  doctest GiftexPlugin

  # plugins defined in test/gifts.yml
  @plugins [
    %GiftexPlugin{type: "test_mail", module: "GiftexPluginMailTest"},
    %GiftexPlugin{type: "test_sms", module: "GiftexPluginSmsTest"}
  ]

  def plugins, do: @plugins

  test "get plugin by name" do
    assert %GiftexPlugin{type: "test_sms", module: "GiftexPluginSmsTest"} == GiftexPlugin.get(@plugins, "test_sms")
  end

  test "get plugin by name not found" do
    assert nil == GiftexPlugin.get(@plugins, "test_unknown_plugin")
  end

  test "exec mail plugin" do
    plugin = Enum.at(@plugins, 0)
    meta = %{"email": "user@mail.com"}

    result = GiftexPlugin.exec(plugin, meta)
    GiftexPluginMailTest.assert_sent(meta)
    assert :ok == result
  end

  test "exec sms plugin" do
    plugin = Enum.at(@plugins, 1)
    meta = %{"number": "+012233445566"}

    result = GiftexPlugin.exec(plugin, meta)
    GiftexPluginSmsTest.assert_sent(meta)
    assert :ok == result
  end
end
