defmodule AuthServiceTest.ConfirmTest do
  use ExUnit.Case
  doctest AuthService


  test "should confirm user's account" do
    user = AuthServiceTest.HelpersTest.create_user()

    {:ok, confirmed_user} = AuthService.Confirm.call(%{
      "uuid" => AuthServiceTest.HelpersTest.test_uuid,
      "confirmation_token" => Map.get(user, :confirmation_token)
    })
    AuthService.Repo.delete!(user)

    assert Map.get(confirmed_user, :confirmed) == true
    assert Map.get(confirmed_user, :confirmation_token) == nil
  end
end
