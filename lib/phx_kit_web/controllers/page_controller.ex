defmodule PhxKitWeb.PageController do
  use PhxKitWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def admin(conn, _params) do
    conn
    |> put_layout({PhxKitWeb.Layouts, :admin})
    |> render(:admin_home)
  end

  def app(conn, _params) do
    conn
    |> put_layout({PhxKitWeb.Layouts, :app})
    |> render(:app_home)
  end
end
