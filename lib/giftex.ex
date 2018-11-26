defmodule Mix.Tasks.Giftex do
  @moduledoc """
  Documentation for Giftex task. Run with 'mix giftex'.
  """
  use Mix.Task

  def run(_args) do
    config = GiftexConfig.read
    plugins = config |> GiftexConfig.plugins
    members = config |> GiftexConfig.members

    members
    |> Enum.shuffle
    |> GiftexDraw.run
    |> Enum.each(fn {from, to} ->
      GiftexMember.exec_plugins(
        plugins,
        GiftexMember.get(members, from),
        GiftexMember.get(members, to)
      )
    end)
  end
end
