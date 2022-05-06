defmodule PentoWeb.Admin.SurveyResultsLive do
  use PentoWeb, :live_component

  alias Pento.Catalog
  alias Contex.Plot

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> assign_age_group_filter()
      |> set_products_with_average_ratings()
      |> assign_dataset()
      |> assign_chart()
      |> assign_chart_svg()

    {:ok, socket}
  end

  def handle_event("age_group_change", %{"age_group_filter" => age_group_filter}, socket) do
    socket =
      socket
      |> assign(age_group_filter: age_group_filter)
      |> set_products_with_average_ratings()
      |> assign_dataset()
      |> assign_chart()
      |> assign_chart_svg()

    {:noreply, socket}
  end

  def assign_gender_filter(%{assigns: %{gender_filter: gender_filter}} = socket) do
    assign(socket, :gender_filter, gender_filter)
  end

  def assign_gender_filter(socket) do
    assign(socket, :gender_filter, "all")
  end

  def assign_age_group_filter(%{assigns: %{age_group_filter: age_group_filter}} = socket) do
    assign(socket, :age_group_filter, age_group_filter)
  end

  def assign_age_group_filter(socket) do
    assign(socket, :age_group_filter, "all")
  end

  def set_products_with_average_ratings(
        %{assigns: %{age_group_filter: age_group_filter}} = socket
      ) do
    case Catalog.list_products_with_average_ratings(%{age_group_filter: age_group_filter}) do
      [] ->
        assign(socket,
          products_with_average_ratings: Catalog.list_products_with_zero_ratings()
        )

      products ->
        assign(socket, products_with_average_ratings: products)
    end
  end

  def assign_dataset(
        %{
          assigns: %{
            products_with_average_ratings: products_with_average_ratings
          }
        } = socket
      ) do
    IO.inspect(products_with_average_ratings)
    assign(socket, dataset: make_bar_chart_dataset(products_with_average_ratings))
  end

  defp make_bar_chart_dataset(data) do
    Contex.Dataset.new(data)
  end

  defp assign_chart(%{assigns: %{dataset: dataset}} = socket) do
    assign(socket, chart: make_bar_chart(dataset))
  end

  defp make_bar_chart(dataset) do
    Contex.BarChart.new(dataset)
  end

  def assign_chart_svg(%{assigns: %{chart: chart}} = socket) do
    assign(socket, chart_svg: render_bar_chart(chart))
  end

  defp render_bar_chart(chart) do
    Plot.new(500, 400, chart)
    |> Plot.titles(title(), subtitle())
    |> Plot.axis_labels(x_axis(), y_axis())
    |> Plot.to_svg()
  end

  defp title do
    "Product Ratings"
  end

  defp subtitle do
    "average star ratings per product"
  end

  defp x_axis do
    "products"
  end

  defp y_axis do
    "stars"
  end
end
