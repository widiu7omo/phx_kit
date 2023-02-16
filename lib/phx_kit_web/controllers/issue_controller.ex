defmodule PhxKitWeb.IssueController do
  use PhxKitWeb, :controller

  alias PhxKit.Maintenance
  alias PhxKit.Maintenance.Issue

  def index(conn, _params) do
    issues = Maintenance.list_issues()
    render(conn, :index, issues: issues)
  end

  def new(conn, _params) do
    changeset = Maintenance.change_issue(%Issue{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"issue" => issue_params}) do
    case Maintenance.create_issue(issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue created successfully.")
        |> redirect(to: ~p"/issues/#{issue}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    issue = Maintenance.get_issue!(id)
    render(conn, :show, issue: issue)
  end

  def edit(conn, %{"id" => id}) do
    issue = Maintenance.get_issue!(id)
    changeset = Maintenance.change_issue(issue)
    render(conn, :edit, issue: issue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "issue" => issue_params}) do
    issue = Maintenance.get_issue!(id)

    case Maintenance.update_issue(issue, issue_params) do
      {:ok, issue} ->
        conn
        |> put_flash(:info, "Issue updated successfully.")
        |> redirect(to: ~p"/issues/#{issue}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, issue: issue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    issue = Maintenance.get_issue!(id)
    {:ok, _issue} = Maintenance.delete_issue(issue)

    conn
    |> put_flash(:info, "Issue deleted successfully.")
    |> redirect(to: ~p"/issues")
  end
end
