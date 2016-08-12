defmodule AuthService.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration


  def change do
    create table(:users, primary_key: false) do

      add :uuid, :string, primary_key: true
      add :email, :string

      add :active, :boolean

      add :confirmed, :boolean
      add :confirmation_token, :string

      add :encrypted_password, :string

      timestamps
    end
    create unique_index(:users, [:email])
  end
end
