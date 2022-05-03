defmodule Pento.Catalog.ProductQuery.Query do
  import Ecto.Query

  alias Pento.Survey.RatingQuery
  alias Pento.Catalog.Product

  def base, do: Product

  def by_user_ratings(user) do
    base()
    |> preload_user_ratings(user)
  end

  def preload_user_ratings(query, user) do
    ratings_query = RatingQuery.Query.preload_user(user)

    query
    |> preload(ratings: ^ratings_query)
  end
end
