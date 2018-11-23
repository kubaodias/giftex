defmodule GiftexConfigTest do
  use ExUnit.Case
  doctest GiftexConfig

  test "read plugins" do
    config = GiftexConfig.read()
    plugins = GiftexConfig.plugins(config)
    assert GiftexPluginTest.plugins == plugins
  end

  test "read members" do
    config = GiftexConfig.read()
    members = GiftexConfig.members(config)
    assert GiftexMemberTest.members == members
  end
end
