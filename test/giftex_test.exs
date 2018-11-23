defmodule GiftexTest do
  use ExUnit.Case
  doctest Mix.Tasks.Giftex

  test "run" do
    Mix.Tasks.Giftex.run([])

    GiftexPluginMailTest.assert_sent(%{"email" => "jwilliams@mail.com"})
    GiftexPluginMailTest.assert_sent(%{"email" => "bmcroe@mail.com"})
    GiftexPluginMailTest.assert_sent(%{"email" => "dsmith@mail.com"})
    GiftexPluginSmsTest.assert_sent(%{"number" => "+01234567890"})
    GiftexPluginSmsTest.assert_sent(%{"number" => "+01098765432"})
  end
end
