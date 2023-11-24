defmodule AssemblyDowntime.DowntimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AssemblyDowntime.Downtimes` context.
  """

  @doc """
  Generate a downtime.
  """
  def downtime_fixture(attrs \\ %{}) do
    {:ok, downtime} =
      attrs
      |> Enum.into(%{
        assembly_number: "some assembly_number",
        corrective_action: "some corrective_action",
        customer_name: "some customer_name",
        date: ~D[2023-11-23],
        explanation: "some explanation",
        initiator_signed_off: true,
        lot_number: 42,
        part_number: "some part_number",
        product_impact: "some product_impact",
        root_cause: "some root_cause",
        shift: "some shift",
        time_equipment_down: ~N[2023-11-23 01:27:00],
        time_equipment_restarted: ~N[2023-11-23 01:27:00]
      })
      |> AssemblyDowntime.Downtimes.create_downtime()

    downtime
  end
end
