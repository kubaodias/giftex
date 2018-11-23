defmodule GiftexMember do
  @moduledoc """
  Documentation for GiftexMember.
  """

  defstruct name: nil,
            plugins_meta: nil

  @doc """
  Execute plugins synchronously accordingly to configured member plugin metadata.
  """
  def exec_plugins(member, plugins) do
    member.plugins_meta
    |> Enum.each(fn {plugin_name, plugin_meta} ->
      GiftexPlugin.get(plugins, plugin_name)
      |> GiftexPlugin.exec(plugin_meta)
    end)
  end
end
