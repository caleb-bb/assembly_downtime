defmodule AssemblyDowntimeWeb.DowntimeLive.Show do
  use AssemblyDowntimeWeb, :live_view

  alias AssemblyDowntime.Downtimes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:downtime, Downtimes.get_downtime!(id))}
  end

  defp page_title(:show), do: "Show Downtime"
  defp page_title(:edit), do: "Edit Downtime"
end
