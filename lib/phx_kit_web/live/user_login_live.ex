defmodule PhxKitWeb.UserLoginLive do
  use PhxKitWeb, :live_view_auth
  @page_title "Login"
  @spec render(any) :: Phoenix.LiveView.Rendered.t()
  def render(assigns) do
    ~H"""
    <.simple_form
      :let={f}
      id="login_form"
      for={:user}
      action={~p"/auth/log_in"}
      as={:user}
      phx-update="ignore"
    >
      <.input field={{f, :email}} type="email" label="Email" required />
      <.input field={{f, :password}} type="password" label="Password" required />

      <:actions :let={f}>
        <.input field={{f, :remember_me}} type="checkbox" label="Keep me logged in" />
        <.link href={~p"/auth/reset_password"} class="text-sm font-semibold">
          Forgot your password?
        </.link>
      </:actions>
      <:actions>
        <.button phx-disable-with="Signing in..." class="w-full">
          Sign in <span aria-hidden="true">→</span>
        </.button>
      </:actions>
    </.simple_form>
    """
  end

  @spec mount(
          any,
          any,
          atom
          | %{:assigns => atom | %{:flash => map, optional(any) => any}, optional(any) => any}
        ) :: {:ok, any, [{:temporary_assigns, [...]}, ...]}
  def mount(_params, _session, socket) do
    email = live_flash(socket.assigns.flash, :email)

    {:ok, assign(socket, email: email, page_title: "Login User", auth_state: "log_in"),
     temporary_assigns: [email: nil]}
  end
end
