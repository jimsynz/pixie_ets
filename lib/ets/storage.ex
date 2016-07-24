defmodule Pixie.ETS.Storage do
  use GenServer

  @moduledoc """
  This module implements a ETS storage so that we only need to use
  a single ETS table for all Pixie's data.
  """

  def start_link do
    GenServer.start_link __MODULE__, [], name: __MODULE__
  end

  def init([]) do
    table = :ets.new __MODULE__, ~w(set protected named_table)a
    {:ok, table}
  end

  def get(key) do
    case :ets.lookup(__MODULE__, key) do
      [{^key, value}] -> value
      _               -> nil
    end
  end

  def exists?(key) do
    case :ets.lookup(__MODULE__, key) do
      [{^key, _}] -> true
      _           -> false
    end
  end

  def set(key, value \\ nil) do
    GenServer.call(__MODULE__, {:set, key, value})
  end

  def delete(key) do
    GenServer.call(__MODULE__, {:delete, key})
  end

  def all(key_type) do
    __MODULE__
    |> :ets.match({{key_type, :"$1"}, :"$2"})
    |> Enum.map(&List.to_tuple(&1))
  end

  def match(spec) do
    __MODULE__
    |> :ets.match(spec)
  end

  def handle_call({:set, key, value}, _, table) do
    {:reply, :ets.insert(__MODULE__, {key, value}), table}
  end

  def handle_call({:delete, key}, _, table) do
    {:reply, :ets.delete(__MODULE__, key), table}
  end
end
