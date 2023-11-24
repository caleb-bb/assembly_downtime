defmodule AssemblyDowntimeWeb.DowntimeLive.Index do
  use AssemblyDowntimeWeb, :live_view

  alias AssemblyDowntime.Downtimes
  alias AssemblyDowntime.Downtimes.Downtime

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :downtimes, Downtimes.list_downtimes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Downtime")
    |> assign(:downtime, Downtimes.get_downtime!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Downtime")
    |> assign(:downtime, %Downtime{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Downtimes")
    |> assign(:downtime, nil)
  end

  @impl true
  def handle_info({AssemblyDowntimeWeb.DowntimeLive.FormComponent, {:saved, downtime}}, socket) do
    {:noreply, stream_insert(socket, :downtimes, downtime)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    downtime = Downtimes.get_downtime!(id)
    {:ok, _} = Downtimes.delete_downtime(downtime)

    {:noreply, stream_delete(socket, :downtimes, downtime)}
  end
end
