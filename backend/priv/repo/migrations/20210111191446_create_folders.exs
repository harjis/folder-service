defmodule Backend.Repo.Migrations.CreateFolders do
  use Ecto.Migration

  def change do
    create table(:folders) do
      add :name, :string, null: false

      add :parent_id, :id
      add :lft, :integer, null: false
      add :rgt, :integer, null: false

      timestamps()
    end

    create index(:folders, [:parent_id])
    create index(:folders, [:lft])
    create index(:folders, [:rgt])
  end
end
