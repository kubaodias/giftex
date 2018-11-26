defmodule GiftexPlugin do
  @moduledoc """
  Documentation for GiftexPlugin.
  """
  @callback exec(Maps.m, %GiftexMember{}, %GiftexMember{}) :: :ok

  require Logger

  defstruct type: nil,
            module: nil,
            config: nil

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
  def exec(plugin, giver, receiver) do
    %GiftexPlugin{module: module_string, config: config} = plugin
    module = ("Elixir." <> module_string) |> String.to_existing_atom
    Logger.debug("Exec plugin #{module_string} for members: #{giver.name} => #{receiver.name}")
    module.exec(config, giver, receiver)
  end

end
