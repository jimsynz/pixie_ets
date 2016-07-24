defmodule Pixie.ETS.Queue do
  alias Pixie.ETS.Storage

  @moduledoc """
  This module implements the temporary storage queue for clients
  who are between active connections.
  """

  def queue(client_id, messages) when is_list(messages) do
    messages
    |> Enum.each(&queue(client_id, &1))
  end

  def queue(client_id, message) do
    queue = [ message | get_queue(client_id) ]
    Storage.set({:queue, client_id}, queue)
  end

  def dequeue(client_id) do
    queue =
      client_id
      |> get_queue
      |> Enum.reverse

    Storage.delete({:queue, client_id})

    queue
  end

  defp get_queue(client_id) do
    Storage.get({:queue, client_id}) || []
  end
end
