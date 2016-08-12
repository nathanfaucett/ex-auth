defmodule AuthService.Get do

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
        {:ok, user}
      end
    end
  end
end
