defmodule AuthServiceTest.AuthorizedPasswordTest do
  use ExUnit.Case
  doctest AuthService


  test "should authorize use if password matches" do
    user = AuthServiceTest.HelpersTest.create_user()

    {:ok, authorized_user} = AuthService.AuthorizedPassword.call(%{
      "locale" => AuthServiceTest.HelpersTest.test_locale,
      "email" => AuthServiceTest.HelpersTest.test_email,
      "password" => AuthServiceTest.HelpersTest.test_password
    })

    assert Map.get(authorized_user, :id) == AuthServiceTest.HelpersTest.test_id


    {:error, errors} = AuthService.AuthorizedPassword.call(%{
      "locale" => AuthServiceTest.HelpersTest.test_locale,
      "email" => "invalid_email@domain.com",
      "password" => "invalid_password"
    })
    AuthService.Repo.delete!(user)

    error = Enum.at(Map.get(errors, "errors"), 0)
    assert Map.get(error, :message) == "User not found"
  end
end
