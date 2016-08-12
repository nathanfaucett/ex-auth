defmodule AuthServiceTest.AuthorizedPasswordTest do
  use ExUnit.Case
  doctest AuthService


  test "should authorize use if password matches" do
    user = AuthServiceTest.HelpersTest.create_user()

    {:ok, authorized_user} = AuthService.AuthorizedPassword.call(%{
      "email" => AuthServiceTest.HelpersTest.test_email,
      "password" => AuthServiceTest.HelpersTest.test_password
    })
    AuthService.Repo.delete!(user)

    assert Map.get(authorized_user, :id) == AuthServiceTest.HelpersTest.test_id
  end
end
