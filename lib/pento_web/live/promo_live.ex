defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view

  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    socket =
      socket
      |> set_recipient()
      |> set_changeset()

    IO.inspect(socket.assigns.changeset)

    {:ok, socket}
  end

  def handle_event("validate", _, socket) do
    #socket = assign(socket, key: value)
    {:noreply, socket}
  end

  def handle_event("submit", %{"recipient" => recipient}, socket) do
    #socket = assign(socket, key: value)
    {:noreply, socket}
  end

  defp set_recipient(socket) do
    socket |> assign(recipient: %Recipient{})
  end

  defp set_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket |> assign(changeset: Promo.change_recipient(recipient))
  end
end
