defmodule Pento.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :username, :string
      add :content, :string
      add :faq_id, references(:faqs, on_delete: :nothing)

      timestamps()
    end

    create index(:answers, [:faq_id])
  end
end
