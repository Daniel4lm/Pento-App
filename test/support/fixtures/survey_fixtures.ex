defmodule Pento.SurveyFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pento.Survey` context.
  """

  alias Pento.Accounts
  import Pento.AccountsFixtures
  alias Pento.Catalog
  alias Pento.Catalog.Product
  import Pento.CatalogFixtures

  @doc """
  Generate a demographic.
  """
  def demographic_fixture(attrs \\ %{}) do
    %{id: id} = user = user_fixture(%{id: 1, email: "daniel4molnar@gmail.com"})
    ruser = Accounts.get_user!(id)

    {:ok, demographic} =
      attrs
      |> Enum.into(%{
        gender: "female",
        education_level: "high school",
        year_of_birth: 1990,
        user_id: id
      })
      |> Pento.Survey.create_demographic()

    demographic
  end

  @doc """
  Generate a rating.
  """
  def rating_fixture(attrs \\ %{}) do
    %{id: id} = user = user_fixture(%{id: 1, email: "daniel4molnar@gmail.com"})
    ruser = Accounts.get_user!(id)

    prod_attrs = %{
      name: "Chess",
      description: "The classic strategy game",
      sku: 5_678_910,
      unit_price: 10.00
    }

    {:ok, %Product{} = product} = Catalog.create_product(prod_attrs)

    {:ok, rating} =
      attrs
      |> Enum.into(%{
        stars: 4,
        user_id: id,
        product_id: product.id
      })
      |> Pento.Survey.create_rating()

    rating
  end
end
