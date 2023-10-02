defmodule KamalWeb.PaymentLive.FormComponent do
  use KamalWeb, :live_component

  alias Kamal.Finance

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage payment records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="payment-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:item]} type="text" label="Item" />
        <.input field={@form[:amount]} type="number" label="Amount" />
        <.input field={@form[:status]} type="text" label="Status" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Payment</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{payment: payment} = assigns, socket) do
    changeset = Finance.change_payment(payment)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"payment" => payment_params}, socket) do
    changeset =
      socket.assigns.payment
      |> Finance.change_payment(payment_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"payment" => payment_params}, socket) do
    save_payment(socket, socket.assigns.action, payment_params)
  end

  defp save_payment(socket, :edit, payment_params) do
    case Finance.update_payment(socket.assigns.payment, payment_params) do
      {:ok, payment} ->
        notify_parent({:saved, payment})

        {:noreply,
         socket
         |> put_flash(:info, "Payment updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_payment(socket, :new, payment_params) do
    case Finance.create_payment(payment_params) do
      {:ok, payment} ->
        notify_parent({:saved, payment})

        {:noreply,
         socket
         |> put_flash(:info, "Payment created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
