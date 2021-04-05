defmodule PostmortemDelivery.Deliveries.Email do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emails" do
    field :expires_at, :utc_datetime
    field :headers, :map
    field :html_body, :string
    field :source_ip, :string
    field :text_body, :string
    field :uri, :string

    timestamps()
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:uri, :html_body, :text_body, :headers, :expires_at, :source_ip])
    |> validate_required([:uri, :html_body, :text_body, :headers, :expires_at, :source_ip])
  end
end
