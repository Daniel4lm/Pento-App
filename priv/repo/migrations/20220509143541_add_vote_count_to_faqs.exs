defmodule Pento.Repo.Migrations.AddVoteCountToFaqs do
  use Ecto.Migration

  def change do
    alter table(:faqs)  do
      add :vote_count, :integer
    end
  end
end
