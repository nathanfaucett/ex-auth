defmodule Auth.Services.User.AuthorizedPassword do
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
      user = Auth.Repo.get_by(Auth.Models.User, email: Map.get(params, "email"))

      if user == nil do
        {:error, %{"errors" => [RuntimeError.exception(dgettext("errors", "No User found that matches email"))]}}
      else
        if Auth.Utils.compare_encrypted(Map.get(params, "password"), Map.get(user, :encrypted_password)) do
          {:ok, user}
        else
          {:error, %{"errors" => [RuntimeError.exception(dgettext("errors", "Invalid Password"))]}}
        end
      end
    end
  end
end
