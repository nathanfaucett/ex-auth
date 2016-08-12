defmodule AuthService.User do
  use Ecto.Schema

  import Ecto.Changeset


  @primary_key false
  schema "users" do

    field :id, :binary_id, primary_key: true
    field :email, :string

    field :active, :boolean, default: true

    field :confirmed, :boolean
    field :confirmation_token, :string

    field :encrypted_password, :string

    timestamps
  end

  @required_fields ~w(id email encrypted_password)
  @optional_fields ~w(active confirmed confirmation_token)

  def create_token() do
    :crypto.strong_rand_bytes(64)
      |> Base.url_encode64()
      |> binary_part(0, 64)
  end

  def changeset(user, params \\ :empty) do
    user
      |> cast(params, @required_fields, @optional_fields)
      |> unique_constraint(:email)
  end
end
