defmodule PentoWeb.HeaderLive.Navbar do
  use PentoWeb, :live_component

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do

    #IO.inspect(assigns)
    socket =
      socket
      |> assign(assigns)

    {:ok, socket}
  end

  def icon(assigns) do
    ~H"""
    <svg
      className={@style.hover}
      width={@style.size}
      height={@style.size}
      viewBox="0 0 93 93"
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
    >
      <path d="M13 64.5L3.53784 73.5081C3.13453 73.8921 2.90625 74.4246 2.90625 74.9814V74.9814C2.90625 76.1049 3.817 77.0156 4.94046 77.0156H88.0595C89.183 77.0156 90.0938 76.1049 90.0938 74.9814V74.9814C90.0938 74.4246 89.8655 73.8921 89.4622 73.5081L80 64.5" stroke={@style.color} stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
      <path d="M13 25C13 22.7909 14.7909 21 17 21H76C78.2091 21 80 22.7909 80 25V61C80 63.2091 78.2091 65 76 65H17C14.7909 65 13 63.2091 13 61V25Z" stroke={@style.color} stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
      <g clipPath="url(#clip0)">
          <path d="M43.2094 49.575C48.3819 49.575 52.575 45.3819 52.575 40.2094C52.575 35.0369 48.3819 30.8438 43.2094 30.8438C38.0369 30.8438 33.8438 35.0369 33.8438 40.2094C33.8438 45.3819 38.0369 49.575 43.2094 49.575Z"
          stroke={@style.color}
          stroke-width="2"
          stroke-miterlimit="10"
          stroke-linecap="round"
          stroke-linejoin="round"
      />
          <path d="M49.8328 46.8328L59.1562 56.1563"
          stroke={@style.color}
          stroke-width="2"
          stroke-miterlimit="10"
          stroke-linecap="round"
          stroke-linejoin="round"
      />
      </g>
      <defs>
          <clipPath id="clip0">
              <rect width="27" height="27" fill="white" transform="translate(33 30)" />
          </clipPath>
      </defs>
    </svg>

    <h2 class="text-[1.5em] tracking-normal font-roboto font-[400] capitalize"><%= @title %></h2>
    """
  end

  def user_menu(assigns) do
    ~H"""
      <ul>
        <%= if @current_user do %>
          <li><%= @current_user.email %></li>
          <li><%= link "Settings", to: Routes.user_settings_path(@socket, :edit) %></li>
          <li><%= link "Log out", to: Routes.user_session_path(@socket, :delete), method: :delete %></li>
        <% else %>
          <li><%= link "Register", to: Routes.user_registration_path(@socket, :new) %></li>
          <li><%= link "Log in", to: Routes.user_session_path(@socket, :new) %></li>
        <% end %>
      </ul>
    """
  end

  @spec link_style(String.t(), String.t(), String.t(), String.t()) :: String.t()
  def link_style(request_path, path, reg_class, active_class) when request_path === path do
    "#{reg_class} " <> active_class
  end

  def link_style(request_path, _path, _reg_class, _active_class) do
    _reg_class
  end

end
