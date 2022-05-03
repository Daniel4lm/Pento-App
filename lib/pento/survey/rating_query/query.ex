defmodule Pento.Survey.RatingQuery.Query do
  import Ecto.Query

  alias Pento.Survey.Rating

  # base for queries
  def base, do: Rating

  def preload_user(user) do
    base()
    |> by_user(user)
  end

  def by_user(query, user) do
    query
    |> where([r], r.user_id == ^user.id)
  end

end
