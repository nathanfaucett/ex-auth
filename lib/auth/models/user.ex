defmodule Auth.Models.User do
  use Ecto.Schema

  import Ecto.Changeset


  @primary_key false
  @derive {Poison.Encoder, only: [:id, :email, :active, :confirmed, :confirmation_token, :inserted_at, :updated_at]}
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

  def changeset(user, params \\ :empty) do
    user
      |> cast(params, @required_fields, @optional_fields)
      |> unique_constraint(:email)
  end
end
