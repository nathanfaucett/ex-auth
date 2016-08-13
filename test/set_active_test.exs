defmodule AuthServiceTest.SetActiveTest do
  use ExUnit.Case
  doctest AuthService


  test "should set active state of user" do
    user = AuthServiceTest.HelpersTest.create_user()
    assert Map.get(user, :active) == true

    {:ok, new_active_state_user} = AuthService.SetActive.call(%{
      "locale" => AuthServiceTest.HelpersTest.test_locale,
      "id" => AuthServiceTest.HelpersTest.test_id,
      "active" => false
    })
    AuthService.Repo.delete!(user)

    assert Map.get(new_active_state_user, :active) == false
  end
end
