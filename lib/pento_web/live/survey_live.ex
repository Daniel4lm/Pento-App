defmodule PentoWeb.SurveyLive do

  use PentoWeb, :live_view

  alias Pento.Survey
  alias PentoWeb.SurveyLive.Header
  alias PentoWeb.SurveyLive.Content
  alias PentoWeb.SurverLive.DemographicLive

  def mount(_params, _session, socket) do


    socket = assign(socket, demographic: get_demographic(socket))
    {:ok, socket}
  end

  def get_demographic(socket) do
    dem_by_user = Survey.get_demographic_by_user(socket.assigns.current_user)
    dem_by_user
  end
end
