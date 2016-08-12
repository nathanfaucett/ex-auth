defmodule AuthService.RegenerateConfirmationToken do

  def prop_types do
    %{
      "uuid" => PropTypes.required(PropTypes.string)
    }
  end

  def call(params) do
    errors = PropTypes.check(params, prop_types, "#{__MODULE__}")

    if errors != nil do
      {:error, errors}
    else
      uuid = Map.get(params, "uuid")
      user = AuthService.Repo.get_by(AuthService.User, uuid: uuid)

      if !user do
        {:error, %{"errors": [RuntimeError.exception("auth_service.user_not_found")]}}
      else
        if Map.get(user, :confirmed) == true do
          {:error, %{"errors": [RuntimeError.exception("auth_service.user_already_confirmed")]}}
        else
          {ok, new_confirmation_token_user} = AuthService.Repo.update(AuthService.User.changeset(user, %{
            :confirmation_token => AuthService.User.create_token(),
          }))

          if ok == :ok do
            {:ok, new_confirmation_token_user}
          else
            {:error, %{"errors": [RuntimeError.exception("auth_service.internal_error")]}}
          end
        end
      end
    end
  end
end
