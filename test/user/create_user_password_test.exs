defmodule AuthServiceTest.User.CreateUserPasswordTest do
  use ExUnit.Case
  doctest Auth


  test "should create user with a password" do
    user = AuthServiceTest.User.HelpersTest.create_user()
    Auth.Repo.delete!(user)

    assert Map.get(user, :email) == AuthServiceTest.User.HelpersTest.test_email
  end
end
