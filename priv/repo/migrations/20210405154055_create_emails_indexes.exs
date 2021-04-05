defmodule PostmortemDelivery.Repo.Migrations.CreateEmailsIndexes do
  use Ecto.Migration

  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    create index(:emails, [:uri], concurrently: true)
    create index(:emails, [:source_ip], concurrently: true)
    create index(:emails, [:expires_at], concurrently: true)
  end
end
