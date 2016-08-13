defmodule AuthServiceTest.User.CreateUserPasswordTest do
  use ExUnit.Case
  doctest AuthService


  test "should create user with a password" do
    user = AuthServiceTest.User.HelpersTest.create_user()
    AuthService.Repo.delete!(user)

    assert Map.get(user, :id) == AuthServiceTest.User.HelpersTest.test_id
    assert Map.get(user, :email) == AuthServiceTest.User.HelpersTest.test_email
  end
end
