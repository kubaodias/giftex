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
      exclude: []
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
    member = Enum.at(@members, 0)
    result = GiftexMember.exec_plugins(member, GiftexPluginTest.plugins)
    assert :ok = result
    GiftexPluginMailTest.assert_sent(member.plugins_meta["test_mail"])
    GiftexPluginSmsTest.assert_sent(member.plugins_meta["test_sms"])
  end
end
