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
      id = UUID.uuid5(:dns, email)

      password = Map.get(params, "password")
      encrypted_password = Bcrypt.hashpwsalt(password)

      {ok, user} = AuthService.Repo.insert(AuthService.User.changeset(%AuthService.User{}, %{
        :id => id,
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
