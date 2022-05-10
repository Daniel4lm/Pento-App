defmodule Pento.Repo.Migrations.CreateFaqs do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :title, :string
      add :question, :string

      timestamps()
    end
  end
end
