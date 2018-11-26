use Mix.Config

config :giftex,
  config: "test/gifts.yml",
  http_client: HTTPClientMock
