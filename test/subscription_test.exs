defmodule Pixie.ETS.SubscriptionTest do
  use ExUnit.Case
  alias Pixie.ETS.{Subscription, Storage, Client, Channel}

  setup do
    Storage.reset!
  end

  test "`create`" do
    Subscription.create("client_id", "channel_name")
    assert Storage.exists?({:subscription, {"client_id", "channel_name"}})
  end

  test "`destroy`" do
    Subscription.create("client_id", "channel_name")
    assert Storage.exists?({:subscription, {"client_id", "channel_name"}})
    Subscription.destroy("client_id", "channel_name")
    refute Storage.exists?({:subscription, {"client_id", "channel_name"}})
  end

  test "`list`" do
    Subscription.create("client_id", "channel_name")
    assert Subscription.list == [{{"client_id", "channel_name"}, nil}]
  end

  test "`exist?` when the subscription exists" do
    Subscription.create("client_id", "channel_name")
    assert Subscription.exists?("client_id", "channel_name")
  end

  test "`exist?` when the subscription doesn't exist" do
    refute Subscription.exists?("client_id", "channel_name")
  end

  test "`clients_on`" do
    make_some_subs
    clients = MapSet.new([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    assert Subscription.clients_on("/channel/3") == clients
  end

  test "`channels_on`" do
    make_some_subs

    clients = MapSet.new([
      "/channel/1",
      "/channel/2",
      "/channel/3",
      "/channel/4",
      "/channel/5",
      "/channel/6",
      "/channel/7",
      "/channel/8",
      "/channel/9",
      "/channel/10"
    ])
    assert Subscription.channels_on("client_3") == clients
  end

  defp make_some_subs do
    1..10
    |> Enum.each(fn (i) ->
      client_id = "client_#{i}"
      1..10
      |> Enum.each(fn (j) ->
        channel = "/channel/#{j}"
        Channel.store(channel)
        Client.store(client_id, i)
        Subscription.create(client_id, channel)
      end)
    end)
  end
end