defmodule PentoWeb.SurveyLive.DemographicLive.Show do
  use Phoenix.Component
  use Phoenix.HTML

  defp is_education?(demographic) do
    if demographic.education_level &&
         demographic.education_level != "prefer not to say" do
      true
    end
  end

  def details(assigns) do
    ~H"""
      <div class="my-8">
        <div class="bg-slate-100 rounded-lg p-4">
          <h2>Demographics <%= raw "&#x2611;" %></h2>
        </div>
        <ul class="text-4xl my-8 mx-4 flex flex-col gap-5">
          <li><b>Gender</b>: <%= @demographic.gender %></li>
          <li><b>Year of birth</b>: <%= @demographic.year_of_birth %></li>
          <%= if is_education?(@demographic) do %>
            <li><b>Education level</b>: <%= @demographic.education_level %></li>
          <% end %>
        </ul>
      </div>
    """
  end
end
