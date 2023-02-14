defmodule PhxKit.Repo.Migrations.AddNameColumnToUsersTable do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add_if_not_exists :name, :string, default: ""
    end
  end
end
