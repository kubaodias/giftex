defmodule GiftexConfig do
  @moduledoc """
  Documentation for GiftexConfig.
  """

  @doc """
  Read configuration from YML file.
  """
  def read do
    config_file = Application.get_env(:giftex, :config)
    config_file
    |> YamlElixir.read_from_file!()
  end

  def plugins(config) do
    config["plugins"]
    |> Enum.map(fn %{"type" => type, "module" => module} ->
       %GiftexPlugin{type: type, module: module}
    end)
  end

  def members(config) do
    config["members"]
    |> Enum.map(fn %{"name" => name, "plugins" => plugins} ->
      plugins_meta = plugins
      |> Enum.map(fn %{"type" => type, "meta" => meta} -> {type, meta} end)
      |> Map.new
      %GiftexMember{name: name, plugins_meta: plugins_meta}
    end)
  end

end
