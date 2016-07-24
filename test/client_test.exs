defmodule Pixie.ETS.ClientTest do
  use ExUnit.Case
  alias Pixie.ETS.{Client, Storage}

  setup do
    Storage.reset!
  end

  test "`store`" do
    Client.store("client_id", :client)
    assert Storage.exists?({:client, "client_id"})
  end

  test "`get` when the client exists" do
    Client.store("client_id", :client)
    assert Client.get("client_id") == :client
  end

  test "`get` when the client doesn't exist" do
    refute Client.get("client_id")
  end

  test "`destroy`" do
    Client.store("client_id", :client)
    assert Storage.exists?({:client, "client_id"})
    Client.destroy("client_id")
    refute Storage.exists?({:client, "client_id"})
  end

  test "`exists?` when the client exists" do
    Client.store("client_id", :client)
    assert Client.exists?("client_id")
  end

  test "`exists?` when the client doesn't exist" do
    refute Client.exists?("client_id")
  end
end