defmodule PentoWeb.FaqLive.Show do
  use PentoWeb, :live_view

  alias Pento.Support
  alias Pento.Repo

  alias PentoWeb.FaqLive.AnswerLive

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(answers: [])
     |> assign(votes: [])
     |> assign(already_answered: false)
     |> assign(already_voted: false)
    }
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    socket =
      socket
      |> assign(page_title: page_title(socket.assigns.live_action))
      |> load_faq(id)

    {:noreply, socket}
  end

  defp load_faq(socket, id) do
    faq =
      id
      |> Support.get_faq!()
      |> Repo.preload([:answers])
      |> Repo.preload([:votes])

    socket =
      socket
      |> assign(faq: faq)
      |> assign(answers: faq.answers)
      |> assign(votes: faq.votes)
      |> user_already_answered()
      |> user_already_voted()
  end

  @impl true
  def handle_event("delete_answer", %{"answer_id" => answer_id},
    %{assigns: %{faq: faq}}  = socket) do
      IO.inspect(faq)
    answer = Support.get_answer!(String.to_integer(answer_id))
    {:ok, _} = Support.delete_answer(answer)

    {:noreply, socket |> load_faq(faq.id)}
  end

  def handle_event("add_like", %{"faq_id" => faq_id, "user_id" => user_id}, socket) do

    vote = Support.add_vote(%{faq_id: faq_id, user_id: user_id})
    #socket = assign(socket, key: value)
    {:noreply, socket |> load_faq(faq_id)}
  end

  @impl true
  def handle_info({:submited_answer, faq}, socket) do
    # new_faq =
    #   faq.id
    #   |> Support.get_faq!()
    #   |> Repo.preload([:answers])

    # socket =
    #   socket
    #   |> put_flash(:info, "Your answer added successfully")
    #   |> assign(faq: faq)
    #   |> assign(answers: faq.answers)
    #   |> user_already_answered()

    {:noreply, socket |> push_patch(to: Routes.faq_show_path(socket, :show, faq))}
  end

  def user_already_voted(%{assigns: %{current_user: current_user, votes: votes}} = socket) do
    isVoted = Enum.any?(votes, fn vote -> vote.user_id == current_user.id end)
    assign(socket, already_voted: isVoted)
  end

  def user_already_answered(%{assigns: %{current_user: current_user, answers: answers}} = socket) do
    isAnswered = Enum.any?(answers, fn ans -> ans.username == current_user.username end)
    assign(socket, already_answered: isAnswered)
  end

  defp page_title(:show), do: "Show Faq"
  defp page_title(:edit), do: "Edit Faq"
end
