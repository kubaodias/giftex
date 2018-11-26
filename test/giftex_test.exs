defmodule GiftexTest do
  use ExUnit.Case
  doctest Mix.Tasks.Giftex

  test "run" do
    Mix.Tasks.Giftex.run([])

    john = Enum.at(GiftexMemberTest.members(), 0)
    bob = Enum.at(GiftexMemberTest.members(), 1)
    diane = Enum.at(GiftexMemberTest.members(), 2)

    GiftexPluginMailTest.assert_sent(john, bob)
    GiftexPluginSmsTest.assert_sent(john, bob)

    GiftexPluginMailTest.assert_sent(bob, diane)

    GiftexPluginMailTest.assert_sent(diane, john)
    GiftexPluginSmsTest.assert_sent(diane, john)
  end
end
