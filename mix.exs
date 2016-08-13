defmodule AuthService.Mixfile do
  use Mix.Project

  def project do
    [app: :auth_service,
     version: "0.0.1",
     description: description,
     package: package,
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     compilers: [:gettext] ++ Mix.compilers]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [
      :gettext,
      :postgrex,
      :ecto,
      :prop_types,
      :uuid,
      :comeonin],
      mod: {AuthService, []}]
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
    [{:gettext, "~> 0.8"},
      {:postgrex, "~> 0.11.2"},
      {:ecto, "~> 2.0.4"},
      {:prop_types, git: "git://github.com/nathanfaucett/ex-prop_types.git"},
      {:uuid, "~> 1.1.4"},
      {:comeonin, "~> 2.5.2"}]
  end

  defp description do
   """
   auth services api for managing users in applications
   """
 end

  defp package do
    [# These are the default files included in the package
      name: :auth_service,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Nathan Faucett"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/nathanfaucett/ex-auth_service",
        "Docs" => "https://github.com/nathanfaucett/ex-auth_service"
      }
    ]
  end
end
