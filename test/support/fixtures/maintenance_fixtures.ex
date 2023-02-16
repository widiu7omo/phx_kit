defmodule PhxKit.MaintenanceFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhxKit.Maintenance` context.
  """

  @doc """
  Generate a issue.
  """
  def issue_fixture(attrs \\ %{}) do
    {:ok, issue} =
      attrs
      |> Enum.into(%{
        content: "some content",
        title: "some title"
      })
      |> PhxKit.Maintenance.create_issue()

    issue
  end
end
