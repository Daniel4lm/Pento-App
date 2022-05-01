defmodule PentoWeb.PromoLive do
  use PentoWeb, :live_view

  alias Pento.Promo
  alias Pento.Promo.Recipient

  def mount(_params, _session, socket) do
    socket =
      socket
      |> set_recipient()
      |> set_changeset()

    #IO.inspect(socket.assigns.changeset)

    {:ok, socket}
  end

  def handle_event("validate", %{"recipient" => recipient_params}, %{assigns: %{recipient: recipient}} = socket) do

    changeset =
      recipient
      |> Promo.change_recipient(recipient_params)
      |> Map.put(:action, :validate)

    socket = assign(socket, changeset: changeset)
    {:noreply, socket}
  end

  def handle_event("submit", %{"recipient" => recipient}, %{assigns: %{changeset: changeset}} = socket) do
    :timer.sleep(1000)
    IO.inspect(recipient)
    IO.inspect(changeset)
    {:noreply, socket}
  end

  defp set_recipient(socket) do
    socket |> assign(recipient: %Recipient{})
  end

  defp set_changeset(%{assigns: %{recipient: recipient}} = socket) do
    socket |> assign(changeset: Promo.change_recipient(recipient))
  end
end
