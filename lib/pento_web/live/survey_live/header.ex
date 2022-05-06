defmodule PentoWeb.SurveyLive.Header do
  use Phoenix.Component

  def header(assigns) do
    ~H"""
        <h2 class="w-max m-auto my-8">
          <%= @title %>
        </h2>
    """
  end
end
