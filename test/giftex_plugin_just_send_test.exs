defmodule GiftexPluginJustSendTest do
  use ExUnit.Case
  doctest GiftexPluginJustSend

  test "exec plugin" do
    HttpClientMock
    |> Mox.expect(:post, fn (_url, _data) -> :ok end)

    plugin_config = %{
      "api_url" => "https://justsend.pl/api/rest",
      "api_key" => "SECRET_KEY",
      "message" => %{
        "title" => "Giftex",
        "text"  => "Hello {{giver}}! Your gift will go to: {{receiver}}..."
      }
    }
    giver = %GiftexMember{
      name: "Bob McRoe",
      plugins_meta: %{
        "sms" => %{"number" => "+01234556789"}
      }
    }
    receiver = %GiftexMember{
      name: "Diane Smith",
      plugins_meta: %{
        "sms" => %{"number" => "+01098765432"}
      },
      exclude: []
    }

    result = GiftexPluginJustSend.exec(plugin_config, giver, receiver)
    assert result == :ok
  end
end
