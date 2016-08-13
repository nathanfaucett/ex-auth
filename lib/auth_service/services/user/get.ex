defmodule AuthService.Services.User.Get do
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

      id = Map.get(params, "uuid")
      user = AuthService.Repo.get_by(AuthService.Models.User, id: id)

      if !user do
        {:error, %{"errors" => [RuntimeError.exception(gettext("user_not_found"))]}}
      else
        {:ok, user}
      end
    end
  end
end
