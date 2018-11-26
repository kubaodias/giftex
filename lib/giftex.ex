defmodule Mix.Tasks.Giftex do
  @moduledoc """
  Documentation for Giftex task. Run with 'mix giftex'.
  """
  use Mix.Task

  require Logger

  def run(_args) do
    Application.ensure_all_started(:httpotion)

    config = GiftexConfig.read
    plugins = config |> GiftexConfig.plugins
    members = config |> GiftexConfig.members

    Logger.debug("Plugins: #{inspect(plugins)}")
    Logger.debug("Members: #{inspect(members)}")

    members
    |> Enum.shuffle
    |> GiftexDraw.run
    |> Enum.each(fn {giver, receiver} ->
      GiftexMember.exec_plugins(
        plugins,
        GiftexMember.get(members, giver),
        GiftexMember.get(members, receiver)
      )
    end)

    Logger.info("Gifts assigned")
  end
end
