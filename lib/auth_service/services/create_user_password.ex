defmodule AuthService.CreateUserPassword do
  alias Comeonin.Bcrypt


  def prop_types do
    %{
      "email" => PropTypes.required(PropTypes.string),
      "password" => PropTypes.required(PropTypes.string)
    }
  end

  def call(params) do
    errors = PropTypes.check(params, prop_types, "#{__MODULE__}")

    if errors != nil do
      {:error, errors}
    else
      email = Map.get(params, "email")
      uuid = UUID.uuid5(:dns, email, :default)

      password = Map.get(params, "password")
      encrypted_password = Bcrypt.hashpwsalt(password)

      {ok, user} = AuthService.Repo.insert(AuthService.User.changeset(%AuthService.User{}, %{
        :uuid => uuid,
        :email => email,

        :confirmed => false,
        :confirmation_token => AuthService.User.create_token(),

        :encrypted_password => encrypted_password
      }))

      if ok == :ok do
        {:ok, user}
      else
        {:error, %{"errors": [RuntimeError.exception("auth_service.internal_error")]}}
      end
    end
  end
end
