defmodule Pixie.ETS.Backend do
  alias Pixie.ETS.{Namespace, Client, Channel, Subscription, Queue, Transport}

  @moduledoc """
  Implements the interface needed by Pixie to call functions in the backend.
  """

  defdelegate generate_namespace(length), to: Namespace, as: :generate
  defdelegate release_namespace(namespace), to: Namespace, as: :release

  defdelegate store_client(client_id, client), to: Client, as: :store
  defdelegate get_client(client_id), to: Client, as: :get
  defdelegate destroy_client(client_id), to: Client, as: :destroy
  defdelegate destroy_client(client_id, reason), to: Client, as: :destroy
  defdelegate list_clients(), to: Client, as: :list
  defdelegate ping_client(client_id), to: Client, as: :ping

  defdelegate store_transport(transport_id, transport), to: Transport, as: :store
  defdelegate get_transport(transport_id), to: Transport, as: :get
  defdelegate destroy_transport(transport_id, pid), to: Transport, as: :destroy
  defdelegate list_transports(), to: Transport, as: :list

  defdelegate store_channel(channel_name), to: Channel, as: :store
  defdelegate get_channel(channel_name), to: Channel, as: :get
  defdelegate destroy_channel(channel_name), to: Channel, as: :destroy
  defdelegate list_channels(), to: Channel, as: :list
  defdelegate match_channels(channel_name), to: Channel, as: :match

  defdelegate subscribe(client_id, channel_name), to: Subscription, as: :create
  defdelegate unsubscribe(client_id, channel_name), to: Subscription, as: :destroy
  defdelegate subscribers_of(channel_name), to: Subscription, as: :clients_on
  defdelegate subscribed_to(client_id), to: Subscription, as: :channels_on
  defdelegate client_subscribed?(client_id, channel_name), to: Subscription, as: :exists?

  defdelegate queue_for(client_id, messages), to: Queue, as: :queue
  defdelegate dequeue_for(client_id), to: Queue, as: :dequeue
end
