defmodule Pixie.ETS.Namespace do
  alias Pixie.ETS.Storage

  @moduledoc """
  This process manages the generation and removal of unique identifiers.
  These are mostly used for client ID's, but can be other stuff too.
  """

  def generate(length) do
    id = UToken.generate(:alphanumeric, length)

    if Storage.exists?({:namespace, id}) do
      generate(length)
    else
      Storage.set({:namespace, id})
    end
    id
  end

  def all do
    :namespace
    |> Storage.all
    |> Enum.map(&elem(&1, 0))
  end

  def exists?(namespace) do
    Storage.exists?({:namespace, namespace})
  end

  def release namespace do
    Storage.delete({:namespace, namespace})
  end
end
