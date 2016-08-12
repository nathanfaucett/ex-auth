defmodule AuthService.Get do

  def prop_types do
    %{
      "id" => PropTypes.required(PropTypes.string)
    }
  end

  def call(params) do
    errors = PropTypes.check(params, prop_types, "#{__MODULE__}")

    if errors != nil do
      {:error, errors}
    else
      id = Map.get(params, "uuid")
      user = AuthService.Repo.get_by(AuthService.User, id: id)

      if !user do
        {:error, %{"errors": [RuntimeError.exception("auth_service.user_not_found")]}}
      else
        {:ok, user}
      end
    end
  end
end
