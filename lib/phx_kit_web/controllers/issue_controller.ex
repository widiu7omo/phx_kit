defmodule PhxKitWeb.IssueController do
  use PhxKitWeb, :controller

  alias PhxKit.Admins
  alias PhxKit.Admins.Issue

  def index(conn, _params) do
    issues = Admins.list_issues()
    render(conn, :index, issues: issues, layout: {PhxKitWeb.Layouts, :admin})
  end

  def new(conn, _params) do
    changeset = Admins.change_issue(%Issue{})
    render(conn, :new, changeset: changeset, layout: {PhxKitWeb.Layouts, :admin})
  end

  def create(conn, %{"issue" => issue_params}) do
    case Admins.create_issue(issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue created successfully.")
        |> redirect(to: ~p"/admin/issues/#{issue}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset, layout: {PhxKitWeb.Layouts, :admin})
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Admins.get_issue!(id)
    render(conn, :show, issue: issue, layout: {PhxKitWeb.Layouts, :admin})
  end

  def edit(conn, %{"id" => id}) do
    issue = Admins.get_issue!(id)
    changeset = Admins.change_issue(issue)
    render(conn, :edit, issue: issue, changeset: changeset, layout: {PhxKitWeb.Layouts, :admin})
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    issue = Admins.get_issue!(id)

    case Admins.update_issue(issue, issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue updated successfully.")
        |> redirect(to: ~p"/admin/issues/#{issue}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit,
          issue: issue,
          changeset: changeset,
          layout: {PhxKitWeb.Layouts, :admin}
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    issue = Admins.get_issue!(id)
    {:ok, _issue} = Admins.delete_issue(issue)

    conn
    |> put_flash(:info, "Issue deleted successfully.")
    |> redirect(to: ~p"/admin/issues")
  end
end
