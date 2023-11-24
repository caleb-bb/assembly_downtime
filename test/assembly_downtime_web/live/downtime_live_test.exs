defmodule AssemblyDowntimeWeb.DowntimeLiveTest do
  use AssemblyDowntimeWeb.ConnCase

  import Phoenix.LiveViewTest
  import AssemblyDowntime.DowntimesFixtures

  @create_attrs %{date: "2023-11-23", customer_name: "some customer_name", assembly_number: "some assembly_number", part_number: "some part_number", lot_number: 42, shift: "some shift", time_equipment_down: "2023-11-23T01:27:00", time_equipment_restarted: "2023-11-23T01:27:00", explanation: "some explanation", root_cause: "some root_cause", corrective_action: "some corrective_action", product_impact: "some product_impact", initiator_signed_off: true}
  @update_attrs %{date: "2023-11-24", customer_name: "some updated customer_name", assembly_number: "some updated assembly_number", part_number: "some updated part_number", lot_number: 43, shift: "some updated shift", time_equipment_down: "2023-11-24T01:27:00", time_equipment_restarted: "2023-11-24T01:27:00", explanation: "some updated explanation", root_cause: "some updated root_cause", corrective_action: "some updated corrective_action", product_impact: "some updated product_impact", initiator_signed_off: false}
  @invalid_attrs %{date: nil, customer_name: nil, assembly_number: nil, part_number: nil, lot_number: nil, shift: nil, time_equipment_down: nil, time_equipment_restarted: nil, explanation: nil, root_cause: nil, corrective_action: nil, product_impact: nil, initiator_signed_off: false}

  defp create_downtime(_) do
    downtime = downtime_fixture()
    %{downtime: downtime}
  end

  describe "Index" do
    setup [:create_downtime]

    test "lists all downtimes", %{conn: conn, downtime: downtime} do
      {:ok, _index_live, html} = live(conn, ~p"/downtimes")

      assert html =~ "Listing Downtimes"
      assert html =~ downtime.customer_name
    end

    test "saves new downtime", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/downtimes")

      assert index_live |> element("a", "New Downtime") |> render_click() =~
               "New Downtime"

      assert_patch(index_live, ~p"/downtimes/new")

      assert index_live
             |> form("#downtime-form", downtime: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#downtime-form", downtime: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/downtimes")

      html = render(index_live)
      assert html =~ "Downtime created successfully"
      assert html =~ "some customer_name"
    end

    test "updates downtime in listing", %{conn: conn, downtime: downtime} do
      {:ok, index_live, _html} = live(conn, ~p"/downtimes")

      assert index_live |> element("#downtimes-#{downtime.id} a", "Edit") |> render_click() =~
               "Edit Downtime"

      assert_patch(index_live, ~p"/downtimes/#{downtime}/edit")

      assert index_live
             |> form("#downtime-form", downtime: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#downtime-form", downtime: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/downtimes")

      html = render(index_live)
      assert html =~ "Downtime updated successfully"
      assert html =~ "some updated customer_name"
    end

    test "deletes downtime in listing", %{conn: conn, downtime: downtime} do
      {:ok, index_live, _html} = live(conn, ~p"/downtimes")

      assert index_live |> element("#downtimes-#{downtime.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#downtimes-#{downtime.id}")
    end
  end

  describe "Show" do
    setup [:create_downtime]

    test "displays downtime", %{conn: conn, downtime: downtime} do
      {:ok, _show_live, html} = live(conn, ~p"/downtimes/#{downtime}")

      assert html =~ "Show Downtime"
      assert html =~ downtime.customer_name
    end

    test "updates downtime within modal", %{conn: conn, downtime: downtime} do
      {:ok, show_live, _html} = live(conn, ~p"/downtimes/#{downtime}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Downtime"

      assert_patch(show_live, ~p"/downtimes/#{downtime}/show/edit")

      assert show_live
             |> form("#downtime-form", downtime: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#downtime-form", downtime: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/downtimes/#{downtime}")

      html = render(show_live)
      assert html =~ "Downtime updated successfully"
      assert html =~ "some updated customer_name"
    end
  end
end
