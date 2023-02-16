defmodule PhxKitWeb.UserController do
  use PhxKitWeb, :controller_admin
  alias PhxKit.Admins
  alias PhxKit.Accounts.User

  @spec index(any, any) :: none
  def index(conn, _params) do
    users = Admins.list_users()

    render(conn, :index, users: users, layout: {PhxKitWeb.Layouts, :admin})
  end

  def new(conn, _params) do
    changeset = Admins.change_user(%User{})
    render(conn, :new, changeset: changeset, layout: {PhxKitWeb.Layouts, :admin})
  end

  def create(conn, %{"user" => user_params}) do
    case Admins.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: ~p"/admin/users/#{user}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, layout: {PhxKitWeb.Layouts, :admin})
    end
  end

  def show(conn, %{"id" => id}) do
    user = Admins.get_user!(id)
    render(conn, :show, user: user, layout: {PhxKitWeb.Layouts, :admin})
  end

  def edit(conn, %{"id" => id}) do
    user = Admins.get_user!(id)
    changeset = Admins.change_user(user)
    render(conn, :edit, user: user, changeset: changeset, layout: {PhxKitWeb.Layouts, :admin})
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Admins.get_user!(id)

    case Admins.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: ~p"/admin/users/#{user}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, user: user, changeset: changeset, layout: {PhxKitWeb.Layouts, :admin})
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Admins.get_user!(id)
    {:ok, _user} = Admins.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: ~p"/admin/users")
  end
end
