defmodule Auth.Models.User do
  use Ecto.Schema

  import Ecto.Changeset


  @primary_key false
  schema "users" do

    field :id, :binary_id, primary_key: true, autogenerate: true
    field :email, :string

    field :active, :boolean, default: true

    field :confirmed, :boolean
    field :confirmation_token, :string

    field :encrypted_password, :string

    timestamps
  end

  @required_fields ~w(email encrypted_password)
  @optional_fields ~w(active confirmed confirmation_token)
  @public_fields [:id, :email, :active, :confirmed, :confirmation_token, :inserted_at, :updated_at]

  def public(user) do
    Enum.reduce(Map.keys(user), %{}, fn (key, acc) ->
      if Enum.member?(@public_fields, key) do
        Map.put(acc, key, Map.get(user, key))
      else
        acc
      end
    end)
  end

  def changeset(user, params \\ :empty) do
    user
      |> cast(params, @required_fields, @optional_fields)
      |> unique_constraint(:email)
  end
end
