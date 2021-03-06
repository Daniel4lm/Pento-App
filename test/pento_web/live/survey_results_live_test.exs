defmodule PentoWeb.SurveyResultsLiveTest do
  use Pento.DataCase
  alias PentoWeb.Admin.SurveyResultsLive

  alias Pento.{Accounts, Survey, Catalog}

  @create_product_attrs %{
    description: "test description",
    name: "Test Game",
    sku: 42,
    unit_price: 120.5
  }
  @create_user_attrs %{
    username: "Test1",
    email: "test@test.com",
    password: "passwordpassword"
  }
  @create_user2_attrs %{
    username: "Test2",
    email: "another-person@email.com",
    password: "passwordpassword"
  }
  @create_demographic_attrs %{
    gender: "female",
    education_level: "student",
    year_of_birth: DateTime.utc_now().year - 15
  }
  @create_demographic2_attrs %{
    gender: "male",
    education_level: "IT",
    year_of_birth: DateTime.utc_now().year - 30
  }
end

defp product_fixture do
  {:ok, product} = Catalog.create_product(@create_product_attrs)
  product
end

defp user_fixture(attrs \\ @create_user_attrs) do
  {:ok, user} = Accounts.register_user(attrs)
  user
end

defp demographic_fixture(user, attrs \\ @create_demographic_attrs) do
  attrs =
    attrs
    |> Map.merge(%{user_id: user.id})

  {:ok, demographic} = Survey.create_demographic(attrs)
  demographic
end

defp rating_fixture(stars, user, product) do
  {:ok, rating} =
    Survey.create_rating(%{
      stars: stars,
      user_id: user.id,
      product_id: product.id
    })

  rating
end

defp create_product(_) do
  product = product_fixture()
  %{product: product}
end

defp create_user(_) do
  user = user_fixture()
  %{user: user}
end

defp create_rating(stars, user, product) do
  rating = rating_fixture(stars, user, product)
  %{rating: rating}
end

defp create_demographic(user) do
  demographic = demographic_fixture(user)
  %{demographic: demographic}
end

defp create_socket(_) do
  %{socket: %Phoenix.LiveView.Socket{}}
end
