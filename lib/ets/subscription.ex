defmodule Pixie.ETS.Subscription do
  alias Pixie.ETS.{Storage, Channel, Client}

  @moduledoc """
  Manages channel subscriptions for clients.
  """

  def create(client_id, channel_name) do
    Storage.set({:subscription, {client_id, channel_name}})
  end

  def destroy(client_id, channel_name) do
    Storage.delete({:subscription, {client_id, channel_name}})
  end

  def list do
    Storage.all(:subscription)
  end

  def exists?(client_id, channel_name) do
    Storage.exists?({:subscription, {client_id, channel_name}})
  end

  def clients_on(channel_name) do
    channel_name
    |> Channel.match
    |> Enum.reduce(MapSet.new, fn (channel_name, clients) ->
      new_clients =
        channel_name
        |> clients_for_channel_name
        |> MapSet.new

      MapSet.union(clients, new_clients)
    end)
  end

  def channels_on(client_id) do
    {{:subscription, {client_id, :"$1"}}, :_}
    |> Storage.match
    |> Enum.reduce(MapSet.new, fn([channel_name], channels) ->
      MapSet.put(channels, channel_name)
    end)
  end

  defp client_ids_for_channel_name(channel_name) do
    Storage.match({{:subscription, {:"$1", channel_name}}, :_})
  end

  defp clients_for_channel_name(channel_name) do
    channel_name
    |> client_ids_for_channel_name
    |> Enum.map(fn ([client_id]) ->
       Client.get(client_id)
    end)
  end
end
