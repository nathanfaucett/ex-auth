defmodule Auth.Services.User.ChangePassword do
  alias Comeonin.Bcrypt
  import Auth.Gettext


  def prop_types do
    %{
      "locale" => PropTypes.required(PropTypes.string),
      "id" => PropTypes.required(PropTypes.string),
      "old_password" => PropTypes.required(PropTypes.string),
      "new_password" => PropTypes.required(PropTypes.string)
    }
  end

  def call(params) do
    errors = PropTypes.check(params, prop_types, "#{__MODULE__}")

    if errors != nil do
      {:error, errors}
    else
      Gettext.put_locale(Auth.Gettext, Map.get(params, "locale"))
      user = Auth.Repo.get_by(Auth.Models.User, id: Map.get(params, "id"))

      if user == nil do
        {:error, %{"errors" => [RuntimeError.exception(dgettext("errors", "User not found"))]}}
      else
        if Bcrypt.checkpw(Map.get(params, "old_password"), Map.get(user, :encrypted_password)) do
          {ok, new_password_user} = Auth.Repo.update(Auth.Models.User.changeset(user, %{
            :encrypted_password => Bcrypt.hashpwsalt(Map.get(params, "new_password")),
          }))

          if ok == :ok do
            {:ok, new_password_user}
          else
            {:error, %{"errors" => [RuntimeError.exception(dgettext("errors", "Internal Error"))]}}
          end
        else
          {:error, %{"errors" => [RuntimeError.exception(dgettext("errors", "Invalid Password"))]}}
        end
      end
    end
  end
end
