defmodule PhxKitWeb.UserRegistrationLive do
  use PhxKitWeb, :live_view_auth

  alias PhxKit.Accounts
  alias PhxKit.Accounts.User

  def render(assigns) do
    ~H"""
    <.simple_form
      :let={f}
      id="registration_form"
      for={@changeset}
      phx-submit="save"
      phx-change="validate"
      phx-trigger-action={@trigger_submit}
      action={~p"/auth/log_in?_action=registered"}
      method="post"
      as={:user}
    >
      <.error :if={@changeset.action == :insert}>
        Oops, something went wrong! Please check the errors below.
      </.error>

      <.input field={{f, :email}} type="email" label="Email" required />
      <.input field={{f, :password}} type="password" label="Password" required />

      <:actions>
        <.button phx-disable-with="Creating account..." class="w-full">Create an account</.button>
      </:actions>
    </.simple_form>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user_registration(%User{})

    socket =
      assign(socket,
        changeset: changeset,
        trigger_submit: false,
        auth_state: "register",
        page_title: "Register"
      )

    {:ok, socket, temporary_assigns: [changeset: nil]}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        {:ok, _} =
          Accounts.deliver_user_confirmation_instructions(
            user,
            &url(~p"/auth/confirm/#{&1}")
          )

        changeset = Accounts.change_user_registration(user)
        {:noreply, assign(socket, trigger_submit: true, changeset: changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Accounts.change_user_registration(%User{}, user_params)
    {:noreply, assign(socket, changeset: Map.put(changeset, :action, :validate))}
  end
end
