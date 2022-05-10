defmodule Pento.Support.Vote do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Support.Faq
  alias Pento.Accounts.User

  schema "votes" do
    belongs_to :faq, Faq
    belongs_to :user, User
    timestamps()
  end

  @doc false
  def changeset(vote, attrs \\ %{}) do
    vote
    |> cast(attrs, [:faq_id, :user_id])
    |> validate_required([:faq_id, :user_id])
  end
end
