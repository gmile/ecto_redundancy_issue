defmodule EctoRedundancyIssue.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_redundancy_issue,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {EctoRedundancyIssue, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, github: "elixir-ecto/ecto", branch: "master"},
      {:postgrex, "~> 0.13.0-rc.0", override: true}
    ]
  end
end
