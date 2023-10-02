defmodule Kamal.FinanceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Kamal.Finance` context.
  """

  @doc """
  Generate a payment.
  """
  def payment_fixture(attrs \\ %{}) do
    {:ok, payment} =
      attrs
      |> Enum.into(%{
        amount: 42,
        item: "some item",
        status: "some status"
      })
      |> Kamal.Finance.create_payment()

    payment
  end
end
