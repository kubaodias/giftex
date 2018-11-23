defmodule GiftexPluginTest do
  use ExUnit.Case
  doctest GiftexPlugin

  # plugins defined in test/gifts.yml
  @plugins [
    %GiftexPlugin{type: "test_mail", module: "GiftexTestMailPlugin"},
    %GiftexPlugin{type: "test_sms", module: "GiftexTestSmsPlugin"}
  ]

  def plugins, do: @plugins

  test "get plugin by name" do
    assert %GiftexPlugin{type: "test_sms", module: "GiftexTestSmsPlugin"} == GiftexPlugin.get(@plugins, "test_sms")
  end

  test "get plugin by name not found" do
    assert nil == GiftexPlugin.get(@plugins, "test_unknown_plugin")
  end
end
