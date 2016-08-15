defmodule AuthTest.User.HelpersTest do
  use ExUnit.Case
  doctest Auth


  @test_locale "en"
  @test_email "email@domain.com"
  @test_password "password"

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
