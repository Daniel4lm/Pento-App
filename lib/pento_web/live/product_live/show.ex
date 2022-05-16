defmodule PentoWeb.ProductLive.Show do
  use PentoWeb, :live_view

  alias Pento.Catalog
  alias PentoWeb.Presence
  alias Pento.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(price_change: 0.0)}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    product = Catalog.get_product!(id)
    maybe_track_user(product, socket)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product, product)}
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"

  def maybe_track_user(
        product,
        %{assigns: %{live_action: :show, current_user: current_user}} = socket
      ) do
    if connected?(socket) do
      Presence.track_user(self(), product, current_user.email)
    end
  end

  def maybe_track_user(product, socket), do: nil

  def handle_event("handle-price-change", %{"price_change" => price_change}, socket) do
    {:noreply, socket |> assign(price_change: price_change)}
  end

  def handle_event(
        "dec-price",
        _,
        %{assigns: %{product: product, price_change: price_change}} = socket
      ) do

    {:ok, markdown_product} = Catalog.markdown_product(product, :decrease, String.to_float(price_change))
    {:noreply, socket |> assign(product: markdown_product)}
  end

  def handle_event(
        "inc-price",
        _,
        %{assigns: %{product: product, price_change: price_change}} = socket
      ) do

    {:ok, markdown_product} = Catalog.markdown_product(product, :increase, String.to_float(price_change))
    {:noreply, socket |> assign(product: markdown_product)}
  end
end
