defmodule Pento.Repo.Migrations.AnswerBodyToText do
  use Ecto.Migration

  def change do
    alter table(:answers) do
      modify :content, :text
    end
  end
end
