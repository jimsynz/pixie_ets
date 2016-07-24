defmodule Pixie.ETS.NamespaceTest do
  use ExUnit.Case
  alias Pixie.ETS.{Namespace, Storage}

  setup do
    Storage.reset!
  end

  test "`generate`" do
    id = Namespace.generate(32)

    assert String.length(id) == 32
    assert Storage.exists?({:namespace, id})
  end

  test "`all` when there are namespaces" do
    ids =
      1..10
      |> Enum.map(fn (_) -> Namespace.generate(32) end )
      |> Enum.sort

    assert Enum.sort(Namespace.all) == ids
  end

  test "`all` when there are no namespaces" do
    assert Namespace.all == []
  end

  test "`exists?` when the namespace exists" do
    id = Namespace.generate(32)
    assert Namespace.exists?(id)
  end

  test "`exists?` when the namespace doesn't exist" do
    id = "fake namespace"
    refute Namespace.exists?(id)
  end

  test "`release`" do
    id =
      32
      |> Namespace.generate
      |> Namespace.release

    refute Namespace.exists?(id)
  end
end