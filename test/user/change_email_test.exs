defmodule AuthTest.User.ChangeEmailTest do
  use ExUnit.Case
  doctest Auth


  test "should change email and unconfirm user" do
    user = AuthTest.User.HelpersTest.create_user()
    old_email = AuthTest.User.HelpersTest.test_email

    {:ok, new_email_user} = Auth.Services.User.ChangeEmail.call(%{
      "locale" => AuthTest.User.HelpersTest.test_locale,
      "id" => Map.get(user, :id),
      "email" => "new_email@domain.com"
    })
    Auth.Repo.delete!(user)

    assert Map.get(new_email_user, :email) != old_email
    assert Map.get(new_email_user, :confirmed) == false
    assert Map.get(new_email_user, :confirmation_token) != nil
  end
end
