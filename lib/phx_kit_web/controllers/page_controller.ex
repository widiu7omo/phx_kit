defmodule PhxKitWeb.PageController do
  use PhxKitWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def admin(conn, _params) do
    render(conn, :admin_home, layout: {PhxKitWeb.Layouts, :admin})
  end

  def app(conn, _params) do
    render(conn, :app_home, layout: {PhxKitWeb.Layouts, :admin})
  end
end
