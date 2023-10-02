defmodule Kamal.Finance.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :amount, :integer
    field :item, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, [:item, :amount, :status])
    |> validate_required([:item, :amount, :status])
  end
end
