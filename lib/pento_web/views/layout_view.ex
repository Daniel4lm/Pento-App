defmodule PentoWeb.LayoutView do
  use PentoWeb, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  @spec link_style(Plug.Conn.t(), String.t(), String.t(), String.t()) :: String.t()
  def link_style(conn, path, reg_class, active_class) when conn.request_path === path do
    "#{reg_class} " <> active_class
  end

  def link_style(conn, _path, _reg_class, _active_class) do
    _reg_class
  end

end
