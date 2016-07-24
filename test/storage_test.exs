defmodule Pixie.ETS.StorageTest do
  use ExUnit.Case
  alias Pixie.ETS.Storage

  setup do
    Storage.reset!
  end

  test "`set` stores the value in ETS" do
    Storage.set("key", "value")
    assert :ets.lookup(Storage, "key") == [{"key", "value"}]
  end

  test "`get` retrieves values from ETS" do
    Storage.set("key", "value")
    assert Storage.get("key") == "value"
  end

  test "`delete` removes a value from ETS" do
    Storage.set("key", "value")
    Storage.delete("key")
    refute Storage.get("key")
  end

  test "`all` retrieves all matching rows for all types of keys" do
    generate_some_data

    values =
      :a
      |> Storage.all
      |> Enum.sort

    assert values == [{1, nil}, {2, nil}, {3, nil}, {4, nil}]
  end

  test "`match` runs a match spec on the table" do
    generate_some_data

    values =
      {{:a, :"$1"}, :_}
      |> Storage.match
      |> Enum.sort

    assert values == [[1], [2], [3], [4]]
  end

  test "`reset!` empties the table" do
    Storage.set("key", "value")
    Storage.reset!
    assert :ets.tab2list(Storage) == []
  end

  defp generate_some_data do
    ~w(a b)a
    |> Enum.each(fn (type) ->
      1..4
      |> Enum.each(fn (i) ->
        Storage.set({type, i})
      end)
    end)
  end
end