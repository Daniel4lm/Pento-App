defmodule Pento.Support.Faq do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Support.Answer
  alias Pento.Support.Vote

  schema "faqs" do
    field :question, :string
    field :title, :string
    field :vote_count, :integer
    has_many :answers, Answer
    has_many :votes, Vote

    timestamps()
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:title, :question, :vote_count])
    |> validate_required([:title, :question])
  end
end
