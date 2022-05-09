defmodule PentoWeb.UserAuthLive do

  import Phoenix.LiveView
  alias Pento.Accounts

  def on_mount(_, _params, session, socket) do
    cur_user = Accounts.get_user_by_session_token(session["user_token"])
    IO.inspect(session)

    socket = assign_new(socket, :current_user, fn -> cur_user end )

    if socket.assigns.current_user do
      {:cont, socket}
    else
      {:halt, redirect(socket, to: "/users/log_in")}
    end
  end
end
