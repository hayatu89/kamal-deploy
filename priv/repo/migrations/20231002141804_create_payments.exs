defmodule Kamal.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :item, :string
      add :amount, :integer
      add :status, :string

      timestamps()
    end
  end
end
