defmodule Kamal.Repo do
  use Ecto.Repo,
    otp_app: :kamal,
    adapter: Ecto.Adapters.Postgres
end
