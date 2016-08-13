defmodule AuthService.Services.User.CreateUserPassword do
  alias Comeonin.Bcrypt
  import AuthService.Gettext


  def prop_types do
    %{
      "locale" => PropTypes.required(PropTypes.string),
      "email" => PropTypes.required(PropTypes.string),
      "password" => PropTypes.required(PropTypes.string)
    }
  end

  def call(params) do
    errors = PropTypes.check(params, prop_types, "#{__MODULE__}")

    if errors != nil do
      {:error, errors}
    else
      Gettext.put_locale(AuthService.Gettext, Map.get(params, "locale"))

      email = Map.get(params, "email")
      id = UUID.uuid5(:dns, email)

      password = Map.get(params, "password")
      encrypted_password = Bcrypt.hashpwsalt(password)

      {ok, user} = AuthService.Repo.insert(AuthService.Models.User.changeset(%AuthService.Models.User{}, %{
        :id => id,
        :email => email,

        :confirmed => false,
        :confirmation_token => AuthService.Models.User.create_token(),

        :encrypted_password => encrypted_password
      }))

      if ok == :ok do
        {:ok, user}
      else
        {:error, %{"errors" => [RuntimeError.exception(gettext("internal_error"))]}}
      end
    end
  end
end
