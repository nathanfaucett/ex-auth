defmodule Auth.Services.User.Confirm do
  import Auth.Gettext


  def prop_types do
    %{
      "locale" => PropTypes.required(PropTypes.string),
      "id" => PropTypes.required(PropTypes.string),
      "confirmation_token" => PropTypes.required(PropTypes.string)
    }
  end

  def call(params) do
    errors = PropTypes.check(params, prop_types, "#{__MODULE__}")

    if errors != nil do
      {:error, errors}
    else
      Gettext.put_locale(Auth.Gettext, Map.get(params, "locale"))

      id = Map.get(params, "id")
      confirmation_token = Map.get(params, "confirmation_token")
      user = Auth.Repo.get_by(Auth.Models.User, id: id)

      if !user do
        {:error, %{"errors" => [RuntimeError.exception(gettext("user_not_found"))]}}
      else
        {ok, confirmed_user} = Auth.Repo.update(Auth.Models.User.changeset(user, %{
          :confirmed => true,
          :confirmation_token => nil
        }))

        if ok == :ok do
          {:ok, confirmed_user}
        else
          {:error, %{"errors" => [RuntimeError.exception(gettext("internal_error"))]}}
        end
      end
    end
  end
end
