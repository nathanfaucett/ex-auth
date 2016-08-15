defmodule AuthTest.User.SetActiveTest do
  use ExUnit.Case
  doctest Auth


  test "should set active state of user" do
    user = AuthTest.User.HelpersTest.create_user()
    assert Map.get(user, :active) == true

    {:ok, new_active_state_user} = Auth.Services.User.SetActive.call(%{
      "locale" => AuthTest.User.HelpersTest.test_locale,
      "id" => Map.get(user, :id),
      "active" => false
    })
    Auth.Repo.delete!(user)

    assert Map.get(new_active_state_user, :active) == false
  end
end
