# AuthService

auth services api for managing users in applications

## Testing

```bash
# create the database
$ mix ecto.create -r AuthService.Repo
# run the migrations
$ mix ecto.migrate -r AuthService.Repo

$ mix test
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add auth_service to your list of dependencies in `mix.exs`:

        def deps do
          [{:auth_service, "~> 0.0.1"}]
        end

  2. Ensure auth_service is started before your application:

        def application do
          [applications: [:auth_service]]
        end


## Usage

```elixir
defmodule Example do

  def example() do

    # create user from email and password
    {:ok, user} = AuthService.CreateUserPassword.call(%{
        "email" => "some_email@domain.com",
        "password" => "some_password"
    })

    # get uuid of user
    uuid = Map.get(user, :uuid)
  end
end

```
