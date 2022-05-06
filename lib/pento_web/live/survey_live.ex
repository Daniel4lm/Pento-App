defmodule PentoWeb.SurveyLive do
  use PentoWeb, :live_view

  alias Pento.Survey
  # -> list_products_with_user_rating
  alias Pento.Catalog
  alias PentoWeb.SurveyLive.Header
  alias PentoWeb.SurveyLive.Content
  alias PentoWeb.SurveyLive.DemographicLive
  alias PentoWeb.SurveyLive.RatingLive
  alias PentoWeb.Endpoint

  @survey_results_topic "survey_results"

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(demographic: get_demographic(socket))
      |> assign(products: get_products(socket))

    {:ok, socket}
  end

  def get_demographic(socket) do
    Survey.get_demographic_by_user(socket.assigns.current_user)
  end

  def get_products(socket) do
    Catalog.list_products_with_user_rating(socket.assigns.current_user)
  end

  def handle_info({:created_demographic, demographic}, socket) do
    socket =
      socket
      |> assign(demographic: demographic)
      |> put_flash(:info, "Demographic created successfully")

    {:noreply, socket}
  end

  def handle_info(
        {:created_rating, product, product_index},
        %{assigns: %{products: products}} = socket
      ) do
    updated_products = List.replace_at(products, product_index, product)

    Endpoint.broadcast(@survey_results_topic, "rating_created", %{}) # I'm new!

    socket =
      socket
      |> put_flash(:info, "Product #{product.name} rated!")
      |> assign(products: updated_products)

    {:noreply, socket}
  end
end
