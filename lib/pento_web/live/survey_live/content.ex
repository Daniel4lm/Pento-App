defmodule PentoWeb.SurveyLive.Content do
  use Phoenix.Component

  def content(assigns) do
    ~H"""
      <h2>
        <%= @content %>
      </h2>
      <h3>
        <%= render_slot(@inner_block) %>
      </h3>
    """
  end
end
