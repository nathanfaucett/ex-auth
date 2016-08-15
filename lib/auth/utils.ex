defmodule Auth.Utils do
  alias Comeonin.Bcrypt


  def encrypt(string), do:
    Bcrypt.hashpwsalt(string)

  def compare_encrypted(string, encrypted), do:
    Bcrypt.checkpw(string, encrypted)

  def create_token(), do:
    :crypto.strong_rand_bytes(64)
      |> Base.url_encode64()
      |> binary_part(0, 64)
end
