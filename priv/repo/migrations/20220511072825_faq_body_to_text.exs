defmodule Pento.Repo.Migrations.FaqBodyToText do
  use Ecto.Migration

  def change do
    alter table(:faqs) do
      modify :question, :text
    end
  end
end
