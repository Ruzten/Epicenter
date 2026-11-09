defmodule EpicenterWeb.MixProject do
  use Mix.Project

  def project do
    [
      app: :epicenter_web,
      version: "0.1.0",
      elixir: "~> 1.20",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      listeners: [Phoenix.CodeReloader],
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      mod: {EpicenterWeb.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:epicenter, path: ".."},
      {:phoenix, "~> 1.8"},
      {:phoenix_html, "~> 4.2"},
      {:phoenix_live_view, "~> 1.1"},
      {:bandit, "~> 1.5"},
      {:jason, "~> 1.4"}
    ]
  end

  defp aliases do
    [setup: ["deps.get"]]
  end
end
