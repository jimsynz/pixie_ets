defmodule Pixie.ETS.TransportTest do
  use ExUnit.Case
  alias Pixie.ETS.{Transport, Storage}

  setup do
    Storage.reset!
  end

  test "`store`" do
    Transport.store("transport_id", self)
    assert Storage.exists?({:transport, "transport_id"})
  end

  test "`get` when the transport exists" do
    Transport.store("transport_id", self)
    assert Transport.get("transport_id") == self
  end

  test "`get` when the transport doesn't exist" do
    refute Transport.get("transport_id")
  end

  test "`destroy`" do
    Transport.store("transport_id", self)
    assert Storage.exists?({:transport, "transport_id"})
    Transport.destroy("transport_id", self)
    refute Storage.exists?({:transport, "transport_id"})
  end

  test "`exists?` when the transport exists" do
    Transport.store("transport_id", self)
    assert Transport.exists?("transport_id")
  end

  test "`exists?` when the transport doesn't exist" do
    refute Transport.exists?("transport_id")
  end
end