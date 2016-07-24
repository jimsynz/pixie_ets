# Pixie.ETS

ETS (in memory) storage backend for [Pixie](https://github.com/messagerocket/pixie).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add pixie_ets to your list of dependencies in `mix.exs`:

        def deps do
          [{:pixie_ets, "~> 0.0.1"}]
        end

  2. Ensure pixie_ets is started before your application:

        def application do
          [applications: [:pixie_ets]]
        end

