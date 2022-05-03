defmodule PentoWeb.SurveyLive.Header do
  use Phoenix.Component

  def header(assigns) do
    ~H"""
        <h2 class="survey-title">
          <%= @title %>
        </h2>
    """
  end
end
