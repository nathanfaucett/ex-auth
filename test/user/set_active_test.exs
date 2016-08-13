defmodule AuthServiceTest.User.SetActiveTest do
  use ExUnit.Case
  doctest AuthService


  test "should set active state of user" do
    user = AuthServiceTest.User.HelpersTest.create_user()
    assert Map.get(user, :active) == true

    {:ok, new_active_state_user} = AuthService.Services.User.SetActive.call(%{
      "locale" => AuthServiceTest.User.HelpersTest.test_locale,
      "id" => AuthServiceTest.User.HelpersTest.test_id,
      "active" => false
    })
    AuthService.Repo.delete!(user)

    assert Map.get(new_active_state_user, :active) == false
  end
end
