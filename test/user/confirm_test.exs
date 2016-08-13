defmodule AuthServiceTest.User.ConfirmTest do
  use ExUnit.Case
  doctest AuthService


  test "should confirm user's account" do
    user = AuthServiceTest.User.HelpersTest.create_user()

    {:ok, confirmed_user} = AuthService.Services.User.Confirm.call(%{
      "locale" => AuthServiceTest.User.HelpersTest.test_locale,
      "id" => AuthServiceTest.User.HelpersTest.test_id,
      "confirmation_token" => Map.get(user, :confirmation_token)
    })
    AuthService.Repo.delete!(user)

    assert Map.get(confirmed_user, :confirmed) == true
    assert Map.get(confirmed_user, :confirmation_token) == nil
  end
end
