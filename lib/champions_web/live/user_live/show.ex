defmodule ChampionsWeb.UserLive.Show do
  use ChampionsWeb, :live_view
  alias Champions.Accounts

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _session, socket) do
    user = Accounts.get_user!(id)

    {:noreply,
      socket
      |> assign(:page_title, "Showing user #{user.email}")
      |> assign(:user, user)
    }
  end

  @impl true
  def handle_event("concede_loss", _value, socket) do
    user = socket.assigns.user

    {:ok, updated_user} = Accounts.update_user_points(user, user.points + 3)
    {:noreply, assign(socket, :user, updated_user)}
  end

  def handle_event("concede_draw", _value, socket) do
    user = socket.assigns.user
    current_user = socket.assigns.current_user

    {:ok, updated_user} = Accounts.update_user_points(user, user.points + 1)
    {:ok, updated_current_user} = Accounts.update_user_points(current_user, current_user.points + 1)

    {:noreply,
      socket
      |> assign(:user, updated_user)
      |> assign(:current_user, updated_current_user)
    }
  end

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      User <%= @user.id%>
      <:subtitle>This is a player on this app.</:subtitle>
    </.header>

    <.list>
      <:item title="Email"><%= @user.email %> </:item>
      <:item title="Points"><%= @user.points %> </:item>
    </.list>

    <div class="my-4">
      <.button type="button" phx-click="concede_loss">I lost to this person</.button>
      <.button type="button" phx-click="concede_draw">Declare draw math</.button>
    </div>

    <.back navigate={~p"/users"}> Back to users </.back>
    """
  end
end
