defmodule PentoWeb.SurverLive.DemographicLive.Form do
  use PentoWeb, :live_component

  alias Pento.Survey
  alias Pento.Survey.Demographic

  def mount(socket) do
    # socket = assign(socket, key: value)
    {:ok, socket}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> set_demo_data()
      |> set_demo_changeset()
    {:ok, socket}
  end

  def set_demo_data(%{assigns: %{current_user: current_user}} = socket) do
    assign(socket, demographic: %Demographic{user_id: current_user.id})
  end

  def set_demo_changeset(%{assigns: %{demographic: demographic}} = socket) do
    assign(socket, changeset: Survey.change_demographic(demographic))
  end
end
