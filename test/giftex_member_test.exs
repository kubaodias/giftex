defmodule GiftexMemberTest do
  use ExUnit.Case
  doctest GiftexMember

  # members defined in test/gifts.yml
  @members [
    %GiftexMember{
      name: "John Williams",
      plugins_meta: %{
        "test_mail" => %{"email" => "jwilliams@mail.com"},
        "test_sms" =>  %{"number" => "+01234567890"}
      },
      exclude: ["Diane Smith"]
    },
    %GiftexMember{
      name: "Bob McRoe",
      plugins_meta: %{
        "test_mail" => %{"email" => "bmcroe@mail.com"}
      },
      exclude: ["John Williams"]
    },
    %GiftexMember{
      name: "Diane Smith",
        plugins_meta: %{
        "test_mail" => %{"email" => "dsmith@mail.com"},
        "test_sms" =>  %{"number" => "+01098765432"}
      },
      exclude: []
    }
  ]

  def members, do: @members

  test "exec plugins" do
    giver     = Enum.at(@members, 0)
    receiver  = Enum.at(@members, 1)
    result    = GiftexMember.exec_plugins(GiftexPluginTest.plugins, giver, receiver)
    assert :ok = result
    GiftexPluginMailTest.assert_sent(giver, receiver)
    GiftexPluginSmsTest.assert_sent(giver, receiver)
  end

  test "get member by name" do
    assert %GiftexMember{
             name: "Bob McRoe",
             plugins_meta: %{
               "test_mail" => %{"email" => "bmcroe@mail.com"}
             },
             exclude: ["John Williams"]
           } == GiftexMember.get(@members, "Bob McRoe")
  end

  test "get member by name not found" do
    assert nil == GiftexMember.get(@members, "Steve McDoe")
  end
end
