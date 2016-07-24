defmodule Pixie.ETS.Backend do
  alias Pixie.ETS.{Namespace, Client, Subscription, Queue}

  @moduledoc """
  Implements the interface needed by Pixie to call functions in the backend.
  """

  def generate_namespace(length \\ 32) do
    length
    |> Namespace.generate
  end

  def release_namespace(namespace) do
    namespace
    |> Namespace.release
  end

  def store_client(%Pixie.Client{} = client) do
    client
    |> Client.store
  end

  def get_client(client_id) do
    client_id
    |> Client.get
  end

  def destroy_client(client_id) do
    client_id
    |> Client.destroy
  end

  def store_channel(channel_name) do
    channel_name
    |> Channel.store
  end

  def get_channel(channel_name) do
    channel_name
    |> Channel.get
  end

  def destroy_channel(channel_name) do
    channel_name
    |> Channel.destroy
  end

  def subscribe(client_id, channel_name) do
    client_id
    |> Subscription.create(channel_name)
  end

  def unsubscribe(client_id, channel_name) do
    client_id
    |> Subscription.destroy(channel_name)
  end

  def subscribers_of(channel_name) do
    channel_name
    |> Subscription.clients_on
  end

  def subscribed_to(client_id) do
    client_id
    Subscription.channels_of
  end

  def client_subscribed?(client_id, channel_name) do
    client_id
    |> Subscription.exists?(channel_name)
  end

  def queue_for(client_id, messages) do
    Queue.queue(client_id, messages)
  end
end
