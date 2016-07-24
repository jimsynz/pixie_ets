defmodule Pixie.ETS.Mixfile do
  use Mix.Project

  def project do
    [app: :pixie_ets,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger],
     mod: {Pixie.ETS, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:u_token,      "~> 0.0.1"},
      {:pixie,        "~> 0.3.5"},
      {:ex_minimatch, "~> 0.0.1"},
      {:dogma,        "~> 0.1.7", only: :dev}
    ]
  end
end
