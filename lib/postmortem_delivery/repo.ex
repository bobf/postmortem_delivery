defmodule PostmortemDelivery.Repo do
  use Ecto.Repo,
    otp_app: :postmortem_delivery,
    adapter: Ecto.Adapters.Postgres
end
