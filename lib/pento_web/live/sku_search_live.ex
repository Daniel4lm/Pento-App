defmodule PentoWeb.SkuSearchLive do
  use PentoWeb, :live_view

  alias Pento.SkuSearch
  alias Pento.SkuSearch.SkuModel
  alias Pento.Catalog.Product

  def mount(_params, _session, socket) do
    socket =
      socket
      |> sku_struct()
      |> sku_changeset()

    {:ok, socket}
  end

  defp sku_struct(socket) do
    socket |> assign(sku: %SkuModel{})
  end

  defp sku_changeset(%{assigns: %{sku: sku}} = socket) do
    socket |> assign(changeset: SkuSearch.change_sku(sku))
  end

  def handle_event("sku-validate", %{"sku_model" => sku_params}, %{assigns: %{sku: sku}} = socket) do
    changeset =
      sku
      |> SkuSearch.change_sku(sku_params)
      |> Map.put(:action, :validate)

    socket = assign(socket, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event(
        "sku-search",
        %{"sku_model" => %{"sku_num" => sku_num}},
        %{assigns: %{sku: sku}} = socket
      ) do
    :timer.sleep(1000)

    case SkuSearch.sku_search(String.to_integer(sku_num)) do
      %Product{} = product ->
        # socket =
        #   socket
        #   |> assign(product: product)

        {:noreply, push_redirect(socket, to: Routes.product_show_path(socket, :show, product))}

      _ ->
        {:noreply, socket |> put_flash(:error, "None product found!")}
    end
  end
end
