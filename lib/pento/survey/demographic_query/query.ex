defmodule Pento.Survey.DemographicQuery.Query do
  import Ecto.Query
  alias Pento.Survey.Demographic

  # basic concepts for queries
  def base do
    Demographic
  end

  def by_user(query \\ base(), user) do
    query
    |> where([d], d.user_id == ^user.id)
  end

end
