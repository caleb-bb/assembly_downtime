defmodule AssemblyDowntime.Repo do
  use Ecto.Repo,
    otp_app: :assembly_downtime,
    adapter: Ecto.Adapters.Postgres
end
