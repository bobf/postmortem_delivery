defmodule PostmortemDelivery.Repo.Migrations.CreateEmails do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :uri, :string
      add :html_body, :text
      add :text_body, :text
      add :from, {:array, :string}
      add :to, {:array, :string}
      add :cc, {:array, :string}
      add :bcc, {:array, :string}
      add :reply_to, {:array, :string}
      add :subject, :text
      add :message_id, :string
      add :source_ip, :string
      add :expires_at, :utc_datetime

      timestamps()
    end

  end
end
