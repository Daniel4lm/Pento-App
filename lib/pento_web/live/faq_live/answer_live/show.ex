defmodule PentoWeb.FaqLive.AnswerLive.Show do

  use Phoenix.Component
  use Phoenix.HTML

  def details(assigns) do
    #IO.inspect(assigns)
    ~H"""
      <div class="answer">

          <h4> <%= @answer.username %> </h4>
          <p> <%= @answer.content %> </p>
          <div class="action">
            <%= if @current_user.username == @answer.username do %>
              <button class="delete"
                phx-click="delete_answer"
                phx-value-answer_id={@answer.id}
                > Delete </button>
            <% end %>
          </div>
      </div>
    """
  end



end
