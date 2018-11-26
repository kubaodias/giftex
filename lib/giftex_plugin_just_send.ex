defmodule GiftexPluginJustSend do
  @moduledoc """
  Plugin used to send text messages using JustSend API (https://justsend.pl).
  """

  @behaviour GiftexPlugin

  require Logger

  @http_client Application.get_env(:giftex, :http_client)

  def exec(config, giver, receiver) do
    api_url = config["api_url"]
    api_key = config["api_key"]
    message = config["message"]
    sms_meta = giver.plugins_meta["sms"]

    request_url = api_url <> "/v2/message/send"
    request_body = Poison.encode!(
      %{
        "to": sms_meta["number"],
        "from": message["title"],
        "message": Mustache.render(message["text"], %{giver: giver.name, receiver: receiver.name}),
        "bulkVariant": "PRO"
      }
    )
    Logger.info("JustSend API: HTTP request POST #{request_url}")
    Logger.debug("req body: #{request_body}")
    rsp = @http_client.post(request_url, [
      body: request_body,
      headers: [
        "Content-Type": "application/json",
        "App-Key": api_key
      ]
    ])
    case rsp do
      %@http_client.Response{status_code: 200, body: body} ->
        Logger.info("JustSend API: HTTP response with body #{body}")
        case Poison.decode!(body) do
          %{"responseCode" => "OK"} ->
            :ok
          %{"responseCode" => response_code, "message" => error_message} ->
            Logger.warn("JustSend API: HTTP response with code: #{response_code}, message: #{error_message}")
            :error
        end
        :ok
      %@http_client.Response{status_code: status_code, body: body} ->
        Logger.error("JustSend API: HTTP response with status_code: #{status_code}, body: #{body}")
        :error
    end
  end
end
