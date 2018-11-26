defmodule GiftexMember do
  @moduledoc """
  Documentation for GiftexMember.
  """

  defstruct name: nil,
            plugins_meta: nil,
            exclude: []

  @doc """
  Execute plugins synchronously accordingly to configured member plugin metadata.
  """
  def exec_plugins(plugins, from, to) do
    from.plugins_meta
    |> Enum.each(fn {plugin_name, _} ->
      GiftexPlugin.get(plugins, plugin_name)
      |> GiftexPlugin.exec(from, to)
    end)
  end

  @doc """
  Get member by name from configuration.
  """
  def get(members, name) do
    Enum.find(members, fn(member) ->
      member.name == name
    end)
  end
end
