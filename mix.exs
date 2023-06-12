defmodule Spike.Surface.MixProject do
  use Mix.Project

  @description "spike_surface helps you build stateul forms / UIs with Surface UI"

  def project do
    [
      app: :spike_surface,
      description: @description,
      version: "0.3.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      source_url: "https://github.com/hubertlepicki/spike-surface",
      homepage_url: "https://github.com/hubertlepicki/spike-surface",
      compilers: [:phoenix] ++ Mix.compilers() ++ [:surface],
      deps: deps(),
      package: package(),
      docs: [
        main: "readme",
        logo: "assets/spike-logo.png",
        extras: ["README.md", "components_library.md"]
      ]
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/hubertlepicki/spike-surface"
      },
      files: ~w(lib mix.exs mix.lock README.md LICENSE components_library.md)
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :surface]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:surface, "~> 0.11"},
      {:spike_liveview, "~> 0.3.0"},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end
end
