defmodule GiftexMemberTest do
  use ExUnit.Case
  doctest GiftexMember

  # members defined in test/gifts.yml
  @members [
    %GiftexMember{name: "John Williams", plugins_meta: %{
      "test_mail" => %{"email" => "jwilliams@mail.com"},
      "test_sms" =>  %{"number" => "+01234567890"}
    }},
    %GiftexMember{name: "Bob McRoe", plugins_meta: %{
      "test_mail" => %{"email" => "bmcroe@mail.com"}
    }},
    %GiftexMember{name: "Diane Smith", plugins_meta: %{
      "test_mail" => %{"email" => "dsmith@mail.com"},
      "test_sms" =>  %{"number" => "+01098765432"}
    }}
  ]

  def members, do: @members
end
