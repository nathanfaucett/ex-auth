defmodule Auth.Services.User.RegenerateConfirmationToken do
  import Auth.Gettext


  def prop_types do
    %{
      "locale" => PropTypes.required(PropTypes.string),
      "id" => PropTypes.required(PropTypes.string)
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
        if Map.get(user, :confirmed) do
          {:error, %{"errors" => [RuntimeError.exception(dgettext("errors", "User already confirmed"))]}}
        else
          {ok, new_confirmation_token_user} = Auth.Repo.update(Auth.Models.User.changeset(user, %{
            :confirmation_token => Auth.Utils.create_token(),
          }))

          if ok == :ok do
            {:ok, new_confirmation_token_user}
          else
            {:error, %{"errors" => [RuntimeError.exception(dgettext("errors", "Internal Error"))]}}
          end
        end
      end
    end
  end
end
