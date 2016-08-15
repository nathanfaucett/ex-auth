defmodule Auth.Services.User.CreateUserPassword do
  alias Comeonin.Bcrypt
  import Auth.Gettext


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
      Gettext.put_locale(Auth.Gettext, Map.get(params, "locale"))

      {ok, user} = Auth.Repo.insert(Auth.Models.User.changeset(%Auth.Models.User{}, %{
        :email => Map.get(params, "email"),

        :confirmed => false,
        :confirmation_token => Auth.Utils.create_token(),

        :encrypted_password => Bcrypt.hashpwsalt(Map.get(params, "password"))
      }))

      if ok == :ok do
        {:ok, user}
      else
        {:error, %{"errors" => [RuntimeError.exception(dgettext("errors", "Internal Error"))]}}
      end
    end
  end
end
