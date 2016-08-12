defmodule AuthServiceTest.HelpersTest do
  use ExUnit.Case
  doctest AuthService


  @test_locale "en"
  @test_email "__test__email__@__test__.com"
  @test_password "!12ABcd"
  @test_id "d9c5be3c-b969-5932-a989-8cda474bed1d"

  def test_locale(), do: @test_locale
  def test_email(), do: @test_email
  def test_password(), do: @test_password
  def test_id(), do: @test_id

  def create_user() do
    {:ok, user} = AuthService.CreateUserPassword.call(%{
      "locale" => @test_locale,
      "email" => @test_email,
      "password" => @test_password
    })
    user
  end
end
