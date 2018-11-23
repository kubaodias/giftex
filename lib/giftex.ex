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
    |> Enum.each(fn member ->
      GiftexMember.exec_plugins(member, plugins)
    end)
  end
end
