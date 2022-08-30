defmodule Graphql.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :content, :text
      add :published, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:posts, [:user_id])
  end
end
