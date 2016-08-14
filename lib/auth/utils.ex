defmodule Auth.Utils do

  def create_uuid() do
    UUID.uuid1()
  end

  def create_token() do
    :crypto.strong_rand_bytes(64)
      |> Base.url_encode64()
      |> binary_part(0, 64)
  end
end
