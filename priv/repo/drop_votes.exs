defmodule Pento.Repo.Migrations.DropVotes do
  use Ecto.Migration

  def change do
    drop table("votes")
  end
end
