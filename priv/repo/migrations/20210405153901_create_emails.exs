defmodule PostmortemDelivery.Repo.Migrations.CreateEmails do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :uri, :string
      add :html_body, :text
      add :text_body, :text
      add :from, :text
      add :to, :text
      add :cc, :text
      add :bcc, :text
      add :reply_to, :text
      add :subject, :text
      add :message_id, :string
      add :source_ip, :string
      add :expires_at, :utc_datetime

      timestamps()
    end

  end
end
