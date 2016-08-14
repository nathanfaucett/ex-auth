defmodule AuthServiceTest.User.HelpersTest do
  use ExUnit.Case
  doctest Auth


  @test_locale "en"
  @test_email "__test__email__@__test__.com"
  @test_password "!12ABcd"

  def test_locale(), do: @test_locale
  def test_email(), do: @test_email
  def test_password(), do: @test_password

  def create_user() do
    {:ok, user} = Auth.Services.User.CreateUserPassword.call(%{
      "locale" => @test_locale,
      "email" => @test_email,
      "password" => @test_password
    })
    user
  end
end
