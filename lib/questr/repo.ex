defmodule Questr.Repo do
  use Ecto.Repo,
    otp_app: :questr,
    adapter: Ecto.Adapters.Postgres
end
