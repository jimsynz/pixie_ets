defmodule Pixie.ETS.Channel do
  alias Pixie.ETS.Storage

  @moduledoc """
  Creates a unique registry of channels and their matcher patterns.
  """

  def store(channel_name) do
    key = {:channel, channel_name}
    unless Storage.exists?(key) do
      key
      |> Storage.set(channel_compile(channel_name))
    end
  end

  def destroy(channel_name) do
    {:channel, channel_name}
    |> Storage.delete
  end

  def exists?(channel_name) do
    {:channel, channel_name}
    |> Storage.exists?
  end

  def get(channel_name) do
    {:channel, channel_name}
    |> Storage.get
  end

  def list do
    :channel
    |> Storage.all
  end

  def match(channel_name) do
    list
    |> Enum.filter_map(
      fn {_, matcher} -> channel_match(matcher, channel_name) end,
      fn {name, _}    -> name end
    )
  end

  defp channel_compile(channel_name) do
    ExMinimatch.compile(channel_name)
  end

  defp channel_match(matcher, channel_name) do
    ExMinimatch.match(matcher, channel_name)
  end
end
