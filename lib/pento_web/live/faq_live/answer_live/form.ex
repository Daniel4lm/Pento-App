defmodule PentoWeb.FaqLive.AnswerLive.Form do
  use PentoWeb, :live_component
  alias Pento.Support
  alias Pento.Support.Answer

  def mount(socket) do
    # socket = assign(socket, key: value)
    {:ok, socket}
  end

  def update(assigns, socket) do
    socket =
      socket
      |> assign(assigns)
      |> set_answer_data()
      |> set_answer_changeset()

    {:ok, socket}
  end

  def set_answer_data(%{assigns: %{current_user: current_user, faq: faq}} = socket) do
    assign(socket, answer: %Answer{faq_id: faq.id, username: current_user.username})
  end

  def set_answer_changeset(%{assigns: %{answer: answer}} = socket) do
    assign(socket, changeset: Support.change_answer(answer))
  end

  def handle_event(
        "validate",
        %{"answer" => answer_params},
        %{assigns: %{answer: answer}} = socket
      ) do
    changeset =
      answer
      |> Support.change_answer(answer_params)
      |> Map.put(:action, :validate)

    {:noreply, socket |> assign(changeset: changeset)}
  end

  def handle_event(
        "save",
        %{"answer" => answer_params},
        %{assigns: %{current_user: current_user, faq: faq}} = socket
      ) do
    case Support.create_answer(answer_params) do
      {:ok, answer} ->
        send(self(), {:submited_answer, faq})

        {:noreply,
         socket
         |> put_flash(:info, "Your answer added successfully")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply,
         socket
         |> assign(changeset: changeset)
         |> put_flash(:error, "Opps, can't add your answer!")}
    end
  end
end
