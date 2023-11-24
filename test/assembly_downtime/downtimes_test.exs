defmodule AssemblyDowntime.DowntimesTest do
  use AssemblyDowntime.DataCase

  alias AssemblyDowntime.Downtimes

  describe "downtimes" do
    alias AssemblyDowntime.Downtimes.Downtime

    import AssemblyDowntime.DowntimesFixtures

    @invalid_attrs %{date: nil, customer_name: nil, assembly_number: nil, part_number: nil, lot_number: nil, shift: nil, time_equipment_down: nil, time_equipment_restarted: nil, explanation: nil, root_cause: nil, corrective_action: nil, product_impact: nil, initiator_signed_off: nil}

    test "list_downtimes/0 returns all downtimes" do
      downtime = downtime_fixture()
      assert Downtimes.list_downtimes() == [downtime]
    end

    test "get_downtime!/1 returns the downtime with given id" do
      downtime = downtime_fixture()
      assert Downtimes.get_downtime!(downtime.id) == downtime
    end

    test "create_downtime/1 with valid data creates a downtime" do
      valid_attrs = %{date: ~D[2023-11-23], customer_name: "some customer_name", assembly_number: "some assembly_number", part_number: "some part_number", lot_number: 42, shift: "some shift", time_equipment_down: ~N[2023-11-23 01:27:00], time_equipment_restarted: ~N[2023-11-23 01:27:00], explanation: "some explanation", root_cause: "some root_cause", corrective_action: "some corrective_action", product_impact: "some product_impact", initiator_signed_off: true}

      assert {:ok, %Downtime{} = downtime} = Downtimes.create_downtime(valid_attrs)
      assert downtime.date == ~D[2023-11-23]
      assert downtime.customer_name == "some customer_name"
      assert downtime.assembly_number == "some assembly_number"
      assert downtime.part_number == "some part_number"
      assert downtime.lot_number == 42
      assert downtime.shift == "some shift"
      assert downtime.time_equipment_down == ~N[2023-11-23 01:27:00]
      assert downtime.time_equipment_restarted == ~N[2023-11-23 01:27:00]
      assert downtime.explanation == "some explanation"
      assert downtime.root_cause == "some root_cause"
      assert downtime.corrective_action == "some corrective_action"
      assert downtime.product_impact == "some product_impact"
      assert downtime.initiator_signed_off == true
    end

    test "create_downtime/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Downtimes.create_downtime(@invalid_attrs)
    end

    test "update_downtime/2 with valid data updates the downtime" do
      downtime = downtime_fixture()
      update_attrs = %{date: ~D[2023-11-24], customer_name: "some updated customer_name", assembly_number: "some updated assembly_number", part_number: "some updated part_number", lot_number: 43, shift: "some updated shift", time_equipment_down: ~N[2023-11-24 01:27:00], time_equipment_restarted: ~N[2023-11-24 01:27:00], explanation: "some updated explanation", root_cause: "some updated root_cause", corrective_action: "some updated corrective_action", product_impact: "some updated product_impact", initiator_signed_off: false}

      assert {:ok, %Downtime{} = downtime} = Downtimes.update_downtime(downtime, update_attrs)
      assert downtime.date == ~D[2023-11-24]
      assert downtime.customer_name == "some updated customer_name"
      assert downtime.assembly_number == "some updated assembly_number"
      assert downtime.part_number == "some updated part_number"
      assert downtime.lot_number == 43
      assert downtime.shift == "some updated shift"
      assert downtime.time_equipment_down == ~N[2023-11-24 01:27:00]
      assert downtime.time_equipment_restarted == ~N[2023-11-24 01:27:00]
      assert downtime.explanation == "some updated explanation"
      assert downtime.root_cause == "some updated root_cause"
      assert downtime.corrective_action == "some updated corrective_action"
      assert downtime.product_impact == "some updated product_impact"
      assert downtime.initiator_signed_off == false
    end

    test "update_downtime/2 with invalid data returns error changeset" do
      downtime = downtime_fixture()
      assert {:error, %Ecto.Changeset{}} = Downtimes.update_downtime(downtime, @invalid_attrs)
      assert downtime == Downtimes.get_downtime!(downtime.id)
    end

    test "delete_downtime/1 deletes the downtime" do
      downtime = downtime_fixture()
      assert {:ok, %Downtime{}} = Downtimes.delete_downtime(downtime)
      assert_raise Ecto.NoResultsError, fn -> Downtimes.get_downtime!(downtime.id) end
    end

    test "change_downtime/1 returns a downtime changeset" do
      downtime = downtime_fixture()
      assert %Ecto.Changeset{} = Downtimes.change_downtime(downtime)
    end
  end
end
