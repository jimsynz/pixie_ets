defmodule Pixie.ETS.QueueTest do
  use ExUnit.Case
  alias Pixie.ETS.{Queue, Storage}

  setup do
    Storage.reset!
  end

  test "`queue` stores messages" do
    messages = ~w(a b c d e f g)
    Queue.queue("client_id", messages)
    assert Queue.dequeue("client_id") == messages
  end

  test "`dequeue` when empty" do
    assert Queue.dequeue("client_id") == []
  end
end