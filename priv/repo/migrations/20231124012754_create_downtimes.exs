defmodule AssemblyDowntime.Repo.Migrations.CreateDowntimes do
  use Ecto.Migration

  def change do
    create table(:downtimes) do
      add :customer_name, :string
      add :assembly_number, :string
      add :part_number, :string
      add :lot_number, :integer
      add :date, :date
      add :shift, :string
      add :time_equipment_down, :naive_datetime
      add :time_equipment_restarted, :naive_datetime
      add :explanation, :string
      add :root_cause, :string
      add :corrective_action, :string
      add :product_impact, :string
      add :initiator_signed_off, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
