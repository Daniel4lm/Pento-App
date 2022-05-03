defmodule PentoWeb.SurverLive.DemographicLive.Show do
  use Phoenix.Component
  use Phoenix.HTML

  def details(assigns) do
    ~H"""
      <div class="survey-component-container">
        <h2>Demographics <%= raw "&#x2611;" %></h2>
        <hr>
        <ul>
          <li><b>Gender</b>: <%= @demographic.gender %></li>
          <li><b>Year of birth</b>: <%= @demographic.year_of_birth %></li>
        </ul>
      </div>
    """
  end
end
