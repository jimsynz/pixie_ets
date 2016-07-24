defmodule Pixie.ETS.Client do
  alias Pixie.ETS.Storage

  @moduledoc """
  This process manages the generation and removal of client processes.
  """

  def store(client_id, client) do
    Storage.set({:client, client_id}, client)
  end

  def get(client_id) do
    Storage.get({:client, client_id})
  end

  def list do
    Storage.all(:client)
  end
end
