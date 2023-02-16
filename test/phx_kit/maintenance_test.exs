defmodule PhxKit.MaintenanceTest do
  use PhxKit.DataCase

  alias PhxKit.Maintenance

  describe "issues" do
    alias PhxKit.Maintenance.Issue

    import PhxKit.MaintenanceFixtures

    @invalid_attrs %{content: nil, title: nil}

    test "list_issues/0 returns all issues" do
      issue = issue_fixture()
      assert Maintenance.list_issues() == [issue]
    end

    test "get_issue!/1 returns the issue with given id" do
      issue = issue_fixture()
      assert Maintenance.get_issue!(issue.id) == issue
    end

    test "create_issue/1 with valid data creates a issue" do
      valid_attrs = %{content: "some content", title: "some title"}

      assert {:ok, %Issue{} = issue} = Maintenance.create_issue(valid_attrs)
      assert issue.content == "some content"
      assert issue.title == "some title"
    end

    test "create_issue/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Maintenance.create_issue(@invalid_attrs)
    end

    test "update_issue/2 with valid data updates the issue" do
      issue = issue_fixture()
      update_attrs = %{content: "some updated content", title: "some updated title"}

      assert {:ok, %Issue{} = issue} = Maintenance.update_issue(issue, update_attrs)
      assert issue.content == "some updated content"
      assert issue.title == "some updated title"
    end

    test "update_issue/2 with invalid data returns error changeset" do
      issue = issue_fixture()
      assert {:error, %Ecto.Changeset{}} = Maintenance.update_issue(issue, @invalid_attrs)
      assert issue == Maintenance.get_issue!(issue.id)
    end

    test "delete_issue/1 deletes the issue" do
      issue = issue_fixture()
      assert {:ok, %Issue{}} = Maintenance.delete_issue(issue)
      assert_raise Ecto.NoResultsError, fn -> Maintenance.get_issue!(issue.id) end
    end

    test "change_issue/1 returns a issue changeset" do
      issue = issue_fixture()
      assert %Ecto.Changeset{} = Maintenance.change_issue(issue)
    end
  end
end
