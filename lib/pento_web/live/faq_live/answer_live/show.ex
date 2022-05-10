defmodule PentoWeb.FaqLive.AnswerLive.Show do

  use Phoenix.Component
  use Phoenix.HTML

  def details(assigns) do
    #IO.inspect(assigns)
    ~H"""
      <div class="answer">
        <h2> <%= @answer.username %> </h2>
        <h2> <%= @answer.content %> </h2>
        <%= if @current_user.username == @answer.username do %>
          <button
            phx-click="delete_answer"
            phx-value-answer_id={@answer.id}
            > Delete </button>
        <% end %>
      </div>
    """
  end



end
