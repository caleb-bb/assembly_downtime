defmodule AssemblyDowntime.Downtimes.Downtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "downtimes" do
    field :date, :date
    field :customer_name, :string
    field :assembly_number, :string
    field :part_number, :string
    field :lot_number, :integer
    field :shift, :string
    field :time_equipment_down, :naive_datetime
    field :time_equipment_restarted, :naive_datetime
    field :explanation, :string
    field :root_cause, :string
    field :corrective_action, :string
    field :product_impact, :string
    field :initiator_signed_off, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(downtime, attrs) do
    downtime
    |> cast(attrs, [:customer_name, :assembly_number, :part_number, :lot_number, :date, :shift, :time_equipment_down, :time_equipment_restarted, :explanation, :root_cause, :corrective_action, :product_impact, :initiator_signed_off])
    |> validate_required([:customer_name, :assembly_number, :part_number, :lot_number, :date, :shift, :time_equipment_down, :time_equipment_restarted, :explanation, :root_cause, :corrective_action, :product_impact, :initiator_signed_off])
  end
end
