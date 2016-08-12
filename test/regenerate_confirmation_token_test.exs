defmodule AuthServiceTest.RegenerateConfirmationTokenTest do
  use ExUnit.Case
  doctest AuthService


  test "should regenerate confirmation token" do
    user = AuthServiceTest.HelpersTest.create_user()
    old_confirmation_token = Map.get(user, :confirmation_token)

    {:ok, new_confirmation_token_user} = AuthService.RegenerateConfirmationToken.call(%{
      "uuid" => AuthServiceTest.HelpersTest.test_uuid
    })

    assert Map.get(new_confirmation_token_user, :confirmed) == false
    assert Map.get(new_confirmation_token_user, :confirmation_token) != old_confirmation_token


    {:ok, confirmed_user} = AuthService.Confirm.call(%{
      "uuid" => AuthServiceTest.HelpersTest.test_uuid,
      "confirmation_token" => Map.get(user, :confirmation_token)
    })
    AuthService.Repo.delete!(user)

    assert Map.get(confirmed_user, :confirmed) == true
    assert Map.get(confirmed_user, :confirmation_token) == nil
  end
end
