defmodule PhxKit.AdminsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhxKit.Admins` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        confirmed_at: ~N[2023-02-12 23:50:00],
        email: "some email",
        hashed_password: "some hashed_password",
        name: "some name"
      })
      |> PhxKit.Admins.create_user()

    user
  end

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
      |> PhxKit.Admins.create_issue()

    issue
  end
end
