defmodule PentoWeb.SurveyLive.RatingLive.Form do

  use PentoWeb, :live_component

  alias Pento.Survey
  alias Pento.Survey.Rating

  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do

    #IO.inspect(assigns)

    socket =
      socket
      |> assign(assigns)
      |> set_rating_data()
      |> set_rating_changeset()

    {:ok, socket}
  end

  def set_rating_data(%{assigns: %{current_user: current_user, product: product}} = socket) do
    assign(socket, rating: %Rating{user_id: current_user.id, product_id: product.id})
  end

  def set_rating_changeset(%{assigns: %{rating: rating}} = socket) do
    assign(socket, changeset: Survey.change_rating(rating))
  end

  def handle_event("validate", %{"rating" => cur_rating_params}, %{assigns: %{rating: rating}} = socket) do

    changeset =
      rating
      |> Survey.change_rating(cur_rating_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"rating" => rating_params}, socket) do
    {:noreply, create_rating_for_product(rating_params,socket)}
  end

  defp create_rating_for_product(rating_params, socket) do

    case Survey.create_rating(rating_params) do
      {:ok, rating} ->
        product = Map.put(socket.assigns.product, :ratings, [rating])
        product_index = socket.assigns.product_index
        send(self(), {:created_rating, product, product_index})
        socket

      {:error, %Ecto.Changeset{} = changeset} ->
        assign(socket, changeset: changeset)
    end
  end

end
