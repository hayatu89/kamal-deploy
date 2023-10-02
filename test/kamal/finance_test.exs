defmodule Kamal.FinanceTest do
  use Kamal.DataCase

  alias Kamal.Finance

  describe "payments" do
    alias Kamal.Finance.Payment

    import Kamal.FinanceFixtures

    @invalid_attrs %{amount: nil, item: nil, status: nil}

    test "list_payments/0 returns all payments" do
      payment = payment_fixture()
      assert Finance.list_payments() == [payment]
    end

    test "get_payment!/1 returns the payment with given id" do
      payment = payment_fixture()
      assert Finance.get_payment!(payment.id) == payment
    end

    test "create_payment/1 with valid data creates a payment" do
      valid_attrs = %{amount: 42, item: "some item", status: "some status"}

      assert {:ok, %Payment{} = payment} = Finance.create_payment(valid_attrs)
      assert payment.amount == 42
      assert payment.item == "some item"
      assert payment.status == "some status"
    end

    test "create_payment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Finance.create_payment(@invalid_attrs)
    end

    test "update_payment/2 with valid data updates the payment" do
      payment = payment_fixture()
      update_attrs = %{amount: 43, item: "some updated item", status: "some updated status"}

      assert {:ok, %Payment{} = payment} = Finance.update_payment(payment, update_attrs)
      assert payment.amount == 43
      assert payment.item == "some updated item"
      assert payment.status == "some updated status"
    end

    test "update_payment/2 with invalid data returns error changeset" do
      payment = payment_fixture()
      assert {:error, %Ecto.Changeset{}} = Finance.update_payment(payment, @invalid_attrs)
      assert payment == Finance.get_payment!(payment.id)
    end

    test "delete_payment/1 deletes the payment" do
      payment = payment_fixture()
      assert {:ok, %Payment{}} = Finance.delete_payment(payment)
      assert_raise Ecto.NoResultsError, fn -> Finance.get_payment!(payment.id) end
    end

    test "change_payment/1 returns a payment changeset" do
      payment = payment_fixture()
      assert %Ecto.Changeset{} = Finance.change_payment(payment)
    end
  end
end
