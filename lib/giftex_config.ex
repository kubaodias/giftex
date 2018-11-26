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
    |> Enum.map(fn %{"type" => type, "module" => module, "config" => config} ->
       %GiftexPlugin{type: type, module: module, config: config}
    end)
  end

  def members(config) do
    config["members"]
    |> Enum.map(fn %{"name" => name, "plugins" => plugins} = member ->
      excluded_members = Map.get(member, "exclude", [])
      plugins_meta = plugins
      |> Enum.map(fn %{"type" => type, "meta" => meta} -> {type, meta} end)
      |> Map.new
      %GiftexMember{name: name, plugins_meta: plugins_meta, exclude: excluded_members}
    end)
  end

end
