defmodule Pixie.ETS.ChannelTest do
  use ExUnit.Case
  alias Pixie.ETS.{Channel, Storage}

  setup do
    Storage.reset!
  end

  test "`store`" do
    Channel.store("channel_name")
    assert Storage.exists?({:channel, "channel_name"})
  end

  test "`destroy`" do
    Channel.store("channel_name")
    Channel.destroy("channel_name")
    refute Storage.exists?({:channel, "channel_name"})
  end

  test "`exists?` when the channel exists" do
    Channel.store("channel_name")
    assert Channel.exists?("channel_name")
  end

  test "`exists?` when the channel doesn't exist" do
    refute Channel.exists?("channel_name")
  end
end