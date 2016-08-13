defmodule AuthService.Services.User.RegenerateConfirmationToken do
  import AuthService.Gettext


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
      Gettext.put_locale(AuthService.Gettext, Map.get(params, "locale"))

      id = Map.get(params, "id")
      user = AuthService.Repo.get_by(AuthService.Models.User, id: id)

      if !user do
        {:error, %{"errors" => [RuntimeError.exception(gettext("user_not_found"))]}}
      else
        if Map.get(user, :confirmed) == true do
          {:error, %{"errors" => [RuntimeError.exception(gettext("user_already_confirmed"))]}}
        else
          {ok, new_confirmation_token_user} = AuthService.Repo.update(AuthService.Models.User.changeset(user, %{
            :confirmation_token => AuthService.Utils.create_token(),
          }))

          if ok == :ok do
            {:ok, new_confirmation_token_user}
          else
            {:error, %{"errors" => [RuntimeError.exception(gettext("internal_error"))]}}
          end
        end
      end
    end
  end
end
