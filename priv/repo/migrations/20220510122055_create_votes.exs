defmodule Pento.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :faq_id, references(:faqs, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      timestamps()
    end

    create index(:votes, [:faq_id, :user_id])
  end
end
