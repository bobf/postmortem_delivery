defmodule PostmortemDelivery.Repo.Migrations.CreateEmails do
  use Ecto.Migration

  def change do
    create table(:emails) do
      add :uri, :string
      add :html_body, :text
      add :text_body, :text
      add :headers, :map
      add :expires_at, :utc_datetime
      add :source_ip, :string

      timestamps()
    end

  end
end
