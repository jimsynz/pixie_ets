defmodule Pixie.ETS do
  use Application

  @moduledoc """
  Starts the application for the Pixie ETS backend.
  """

  def start(_type, _args) do
    children
    |> Supervisor.start_link(opts)
  end

  defp children do
    import Supervisor.Spec, warn: false
    [
      worker(Pixie.ETS.Storage, [])
    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: Pixie.ETS.Supervisor
    ]
  end
end
