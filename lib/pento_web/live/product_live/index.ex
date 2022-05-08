defmodule PentoWeb.ProductLive.Index do
  use PentoWeb, :live_view

  alias Pento.Catalog
  alias Pento.Catalog.Product

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(products: list_products())
      |> assign(sort_options: %{sort_order: :asc})

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"sort_by" => sort_by, "sort_order" => sort_order}, _url, socket) do
    IO.puts("sort by ...")

    sort_by = sort_by |> String.to_atom()
    sort_order = (sort_order || "asc") |> String.to_atom()

    sort_options = %{sort_order: sort_order}
    socket =
      socket
      |> assign(products: Catalog.sort_products(sort_by, sort_options))
      |> assign(sort_options: sort_options)

      IO.inspect(socket)
    {:noreply, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Catalog.get_product!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Catalog.get_product!(id)
    {:ok, _} = Catalog.delete_product(product)

    {:noreply, assign(socket, :products, list_products())}
  end

  defp list_products do
    Catalog.list_products()
  end

  def sort_link(socket, text, sort_by, options, _class) do
    live_patch(
      text,
      to:
        Routes.product_index_path(
          socket,
          :index,
          %{
            sort_by: sort_by,
            sort_order: toggle_sort_order(options.sort_order)
          }
        ),
      class: _class
    )
  end

  def toggle_sort_order(:asc), do: :desc
  def toggle_sort_order(:desc), do: :asc
end
