defmodule Pento.Repo.Migrations.DropFaqs do
  use Ecto.Migration

  def change do
    drop table("faqs")
  end
end
