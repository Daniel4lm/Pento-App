defmodule PentoWeb.SurveyLive.DemographicLive.Form do
  use PentoWeb, :live_component

  alias Pento.Survey
  alias Pento.Survey.Demographic

  def mount(socket) do
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

  def handle_event("validate", %{"demographic" => demographic_params}, socket) do
    {:noreply, socket}
  end

  def handle_event("save", %{"demographic" => demographic_params}, socket) do
    {:noreply, create_demographic_for_user(demographic_params, socket)}
  end

  defp create_demographic_for_user(demographic_params, socket) do
    case Survey.create_demographic(demographic_params) do
      {:ok, %Demographic{} = demographic} ->
        send(self(), {:created_demographic, demographic})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, changeset: changeset)
    end
  end
end
