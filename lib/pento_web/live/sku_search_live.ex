defmodule PentoWeb.SkuSearchLive do

  use PentoWeb, :live_view

  def mount(_params, _session, socket) do

    #socket = assign(socket, key: value)
    {:ok, socket}
  end

  def handle_event(event, _, socket) do

    #socket = assign(socket, key: value)
    {:noreply, socket}
  end

end
