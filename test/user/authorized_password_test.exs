defmodule AuthTest.User.AuthorizedPasswordTest do
  use ExUnit.Case
  doctest Auth


  test "should authorize use if password matches" do
    user = AuthTest.User.HelpersTest.create_user()

    {:ok, authorized_user} = Auth.Services.User.AuthorizedPassword.call(%{
      "locale" => AuthTest.User.HelpersTest.test_locale,
      "email" => AuthTest.User.HelpersTest.test_email,
      "password" => AuthTest.User.HelpersTest.test_password
    })

    assert Map.get(authorized_user, :email) == AuthTest.User.HelpersTest.test_email


    {:error, errors} = Auth.Services.User.AuthorizedPassword.call(%{
      "locale" => AuthTest.User.HelpersTest.test_locale,
      "email" => "invalid_email@domain.com",
      "password" => "invalid_password"
    })
    Auth.Repo.delete!(user)

    error = Enum.at(Map.get(errors, "errors"), 0)
    assert Map.get(error, :message) == "User not found"
  end
end
