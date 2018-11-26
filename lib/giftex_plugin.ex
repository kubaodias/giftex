defmodule GiftexPlugin do
  @moduledoc """
  Documentation for GiftexPlugin.
  """
  @callback exec(%GiftexMember{}, %GiftexMember{}) :: :ok

  defstruct type: nil,
            module: nil

  @doc """
  Get plugin by name from configuration.
  """
  def get(plugins, name) do
    Enum.find(plugins, fn(plugin) ->
      plugin.type == name
    end)
  end

  @doc """
  Execute plugin job with some metadata.
  """
  def exec(plugin, from, to) do
    %GiftexPlugin{module: module_string} = plugin
    module = ("Elixir." <> module_string) |> String.to_existing_atom
    module.exec(from, to)
  end

end
