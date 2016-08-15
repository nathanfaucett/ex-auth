defmodule AuthTest.User.ChangePasswordTest do
  use ExUnit.Case
  doctest Auth


  test "should change password" do
    user = AuthTest.User.HelpersTest.create_user()
    old_encrypted_password = Map.get(user, :encrypted_password)

    {:ok, new_password_user} = Auth.Services.User.ChangePassword.call(%{
      "locale" => AuthTest.User.HelpersTest.test_locale,
      "id" => Map.get(user, :id),
      "old_password" => AuthTest.User.HelpersTest.test_password,
      "new_password" => "new_password"
    })
    Auth.Repo.delete!(user)

    assert Map.get(new_password_user, :encrypted_password) != old_encrypted_password
  end
end
