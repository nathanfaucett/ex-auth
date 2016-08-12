defmodule AuthService.Confirm do

  def prop_types do
    %{
      "id" => PropTypes.required(PropTypes.string),
      "confirmation_token" => PropTypes.required(PropTypes.string)
    }
  end

  def call(params) do
    errors = PropTypes.check(params, prop_types, "#{__MODULE__}")

    if errors != nil do
      {:error, errors}
    else
      id = Map.get(params, "id")
      confirmation_token = Map.get(params, "confirmation_token")
      user = AuthService.Repo.get_by(AuthService.User, id: id)

      if !user do
        {:error, %{"errors": [RuntimeError.exception("auth_service.user_not_found")]}}
      else
        {ok, confirmed_user} = AuthService.Repo.update(AuthService.User.changeset(user, %{
          :confirmed => true,
          :confirmation_token => nil
        }))

        if ok == :ok do
          {:ok, confirmed_user}
        else
          {:error, %{"errors": [RuntimeError.exception("auth_service.internal_error")]}}
        end
      end
    end
  end
end
