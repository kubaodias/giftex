defmodule GiftexPlugin do
  @moduledoc """
  Documentation for GiftexPlugin.
  """

  defstruct type: nil,
            module: nil

  def get(plugins, name) do
    Enum.find(plugins, fn(plugin) ->
      plugin.type == name
    end)
  end

end
