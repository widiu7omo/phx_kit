defmodule PhxKit.Repo do
  use Ecto.Repo,
    otp_app: :phx_kit,
    adapter: Ecto.Adapters.Postgres
end
