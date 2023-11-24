defmodule AssemblyDowntimeWeb.DowntimeLive.FormComponent do
  use AssemblyDowntimeWeb, :live_component

  alias AssemblyDowntime.Downtimes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage downtime records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="downtime-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:customer_name]} type="text" label="Customer name" />
        <.input field={@form[:assembly_number]} type="text" label="Assembly number" />
        <.input field={@form[:part_number]} type="text" label="Part number" />
        <.input field={@form[:lot_number]} type="number" label="Lot number" />
        <.input field={@form[:date]} type="date" label="Date" />
        <.input field={@form[:shift]} type="text" label="Shift" />
        <.input field={@form[:time_equipment_down]} type="datetime-local" label="Time equipment down" />
        <.input field={@form[:time_equipment_restarted]} type="datetime-local" label="Time equipment restarted" />
        <.input field={@form[:explanation]} type="text" label="Explanation" />
        <.input field={@form[:root_cause]} type="text" label="Root cause" />
        <.input field={@form[:corrective_action]} type="text" label="Corrective action" />
        <.input field={@form[:product_impact]} type="text" label="Product impact" />
        <.input field={@form[:initiator_signed_off]} type="checkbox" label="Initiator signed off" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Downtime</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{downtime: downtime} = assigns, socket) do
    changeset = Downtimes.change_downtime(downtime)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"downtime" => downtime_params}, socket) do
    changeset =
      socket.assigns.downtime
      |> Downtimes.change_downtime(downtime_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"downtime" => downtime_params}, socket) do
    save_downtime(socket, socket.assigns.action, downtime_params)
  end

  defp save_downtime(socket, :edit, downtime_params) do
    case Downtimes.update_downtime(socket.assigns.downtime, downtime_params) do
      {:ok, downtime} ->
        notify_parent({:saved, downtime})

        {:noreply,
         socket
         |> put_flash(:info, "Downtime updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_downtime(socket, :new, downtime_params) do
    case Downtimes.create_downtime(downtime_params) do
      {:ok, downtime} ->
        notify_parent({:saved, downtime})

        {:noreply,
         socket
         |> put_flash(:info, "Downtime created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
