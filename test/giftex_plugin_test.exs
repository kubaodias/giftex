defmodule GiftexPluginTest do
  use ExUnit.Case
  doctest GiftexPlugin

  # plugins defined in test/gifts.yml
  @plugins [
    %GiftexPlugin{type: "test_mail", module: "GiftexPluginMailTest", config: %{"smtp_server" => "10.0.0.10:465"}},
    %GiftexPlugin{type: "test_sms", module: "GiftexPluginSmsTest", config: %{"sms_gateway" => "sms://message.com/gw"}}
  ]

  def plugins, do: @plugins

  test "get plugin by name" do
    assert %GiftexPlugin{type: "test_sms", module: "GiftexPluginSmsTest", config: %{"sms_gateway" => "sms://message.com/gw"}} ==
            GiftexPlugin.get(@plugins, "test_sms")
  end

  test "get plugin by name not found" do
    assert nil == GiftexPlugin.get(@plugins, "test_unknown_plugin")
  end

  test "exec mail plugin" do
    plugin    = Enum.at(@plugins, 0)
    giver     = Enum.at(GiftexMemberTest.members, 0)
    receiver  = Enum.at(GiftexMemberTest.members, 1)

    result = GiftexPlugin.exec(plugin, giver, receiver)
    GiftexPluginMailTest.assert_sent(giver, receiver)
    assert :ok == result
  end

  test "exec sms plugin" do
    plugin    = Enum.at(@plugins, 1)
    giver     = Enum.at(GiftexMemberTest.members, 0)
    receiver  = Enum.at(GiftexMemberTest.members, 1)

    result = GiftexPlugin.exec(plugin, giver, receiver)
    GiftexPluginSmsTest.assert_sent(giver, receiver)
    assert :ok == result
  end
end
