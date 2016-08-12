defmodule AuthServiceTest.HelpersTest do
  use ExUnit.Case
  import Ecto.Query, only: [from: 2]
  doctest AuthService


  @test_email "__test__email__@__test__.com"
  @test_password "!12ABcd"
  @test_id "d9c5be3c-b969-5932-a989-8cda474bed1d"

  def test_email() do
    @test_email
  end

  def test_password() do
    @test_password
  end

  def test_id() do
    @test_id
  end

  def create_user() do
    {:ok, user} = AuthService.CreateUserPassword.call(%{
      "email" => @test_email,
      "password" => @test_password
    })
    user
  end
end
