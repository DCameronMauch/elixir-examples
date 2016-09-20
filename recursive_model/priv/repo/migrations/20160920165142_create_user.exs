defmodule RecursiveModel.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :parent_id, references(:users, on_delete: :nothing)
      timestamps()
    end
    create index(:users, [:parent_id])
  end
end
