defmodule PostmortemDelivery.Deliveries.Email do
  use Ecto.Schema
  import Ecto.Changeset

  schema "emails" do
    field :uri, :string
    field :html_body, :string
    field :text_body, :string
    field :from, {:array, :string}
    field :to, {:array, :string}
    field :cc, {:array, :string}
    field :bcc, {:array, :string}
    field :reply_to, {:array, :string}
    field :subject, :string
    field :message_id, :string
    field :source_ip, :string
    field :expires_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(email, attrs) do
    email
    |> cast(attrs, [:uri, :html_body, :text_body, :expires_at, :source_ip, :from, :to, :cc, :bcc, :reply_to, :subject, :message_id])
    |> validate_required([:uri, :expires_at, :source_ip])
  end
end
