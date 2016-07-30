defmodule Pixie.ETS.Client do
  alias Pixie.ETS.Storage

  @moduledoc """
  This process manages the generation and removal of client processes.
  """

  def store(client_id, pid) when is_pid(pid) do
    Storage.set({:client, client_id}, pid)
  end

  def get(client_id) do
    Storage.get({:client, client_id})
  end

  def destroy(client_id, _reason \\ nil) do
    Storage.delete({:client, client_id})
  end

  def ping(_client_id), do: nil

  def exists?(client_id) do
    Storage.exists?({:client, client_id})
  end

  def list do
    Storage.all(:client)
  end
end
