defmodule AuthTest.User.CreateUserPasswordTest do
  use ExUnit.Case
  doctest Auth


  test "should create user with a password" do
    user = AuthTest.User.HelpersTest.create_user()
    Auth.Repo.delete!(user)

    assert Map.get(user, :email) == AuthTest.User.HelpersTest.test_email
  end
end
