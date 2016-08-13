defmodule AuthService.Services.User.SetActive do
  import AuthService.Gettext


  def prop_types do
    %{
      "locale" => PropTypes.required(PropTypes.string),
      "id" => PropTypes.required(PropTypes.string),
      "active" => PropTypes.required(PropTypes.boolean)
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
        active = Map.get(params, "active")

        if Map.get(user, :active) == active do
          {:ok, user}
        else
          {ok, new_active_state_user} = AuthService.Repo.update(AuthService.Models.User.changeset(user, %{
            :active => active,
          }))

          if ok == :ok do
            {:ok, new_active_state_user}
          else
            {:error, %{"errors" => [RuntimeError.exception(gettext("internal_error"))]}}
          end
        end
      end
    end
  end
end
