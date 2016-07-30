defmodule Pixie.ETS.Transport do
  alias Pixie.ETS.Storage

  @moduledoc """
  This process manages the generation and removal of transport processes.
  """

  def store(transport_id, pid) when is_pid(pid) do
    Storage.set({:transport, transport_id}, pid)
  end

  def get(transport_id) do
    Storage.get({:transport, transport_id})
  end

  def destroy(transport_id, pid) do
    if Storage.get({:transport, transport_id}) == pid do
      Storage.delete({:transport, transport_id})
    end
  end

  def exists?(transport_id) do
    Storage.exists?({:transport, transport_id})
  end

  def list do
    Storage.all(:transport)
  end
end
