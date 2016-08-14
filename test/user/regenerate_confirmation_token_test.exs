defmodule AuthServiceTest.User.RegenerateConfirmationTokenTest do
  use ExUnit.Case
  doctest Auth


  test "should regenerate confirmation token" do
    user = AuthServiceTest.User.HelpersTest.create_user()
    old_confirmation_token = Map.get(user, :confirmation_token)

    {:ok, new_confirmation_token_user} = Auth.Services.User.RegenerateConfirmationToken.call(%{
      "locale" => AuthServiceTest.User.HelpersTest.test_locale,
      "id" => Map.get(user, :id)
    })

    new_confirmation_token = Map.get(new_confirmation_token_user, :confirmation_token)
    assert new_confirmation_token != old_confirmation_token


    {:ok, confirmed_user} = Auth.Services.User.Confirm.call(%{
      "locale" => AuthServiceTest.User.HelpersTest.test_locale,
      "id" => Map.get(user, :id),
      "confirmation_token" => new_confirmation_token
    })
    Auth.Repo.delete!(user)

    assert Map.get(confirmed_user, :confirmed) == true
    assert Map.get(confirmed_user, :confirmation_token) == nil
  end
end
