# Auth [![Build Status](https://travis-ci.org/nathanfaucett/ex-auth.svg?branch=master)](https://travis-ci.org/nathanfaucett/ex-auth)

auth services api for managing users in applications

## Testing

```bash
# create the database
$ mix ecto.drop -r Auth.Repo &&
  mix ecto.create -r Auth.Repo &&
  mix ecto.migrate -r Auth.Repo

$ mix test
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add auth to your list of dependencies in `mix.exs`:

        def deps do
          [{:auth, "~> 0.0.1"}]
        end

  2. Ensure auth is started before your application:

        def application do
          [applications: [:auth]]
        end


## Usage

```elixir
# Main Modules
# Auth.Repo
# Auth.Models.User
# Auth.Services.User

defmodule Example do

  def example() do

    # create user from email and password
    {:ok, user} = Auth.Services.User.CreateUserPassword.call(%{
        "email" => "some_email@domain.com",
        "password" => "some_password"
    })

    # get uuid of user
    uuid = Map.get(user, :uuid)
  end
end

```
