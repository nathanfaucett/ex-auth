defmodule Auth.Services.User.SetActive do
  import Auth.Gettext


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
      Gettext.put_locale(Auth.Gettext, Map.get(params, "locale"))

      user = Auth.Repo.get_by(Auth.Models.User, id: Map.get(params, "id"))

      if user == nil do
        {:error, %{"errors" => [RuntimeError.exception(dgettext("errors", "User not found"))]}}
      else
        active = Map.get(params, "active")

        if Map.get(user, :active) == active do
          {:ok, user}
        else
          {ok, new_active_state_user} = Auth.Repo.update(Auth.Models.User.changeset(user, %{
            :active => active,
          }))

          if ok == :ok do
            {:ok, new_active_state_user}
          else
            {:error, %{"errors" => [RuntimeError.exception(dgettext("errors", "Internal Error"))]}}
          end
        end
      end
    end
  end
end
