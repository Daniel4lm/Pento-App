defmodule Pento.Support.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  alias Pento.Support.Faq

  schema "answers" do
    field :content, :string
    field :username, :string
    belongs_to :faq, Faq

    timestamps()
  end

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [:username, :content, :faq_id])
    |> validate_required([:username, :content, :faq_id])
  end
end
