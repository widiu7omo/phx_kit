defmodule PhxKit.Admins do
  @moduledoc """
  The Admins context.
  """

  import Ecto.Query, warn: false
  alias PhxKit.Repo

  alias PhxKit.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    dbg(attrs)

    %User{}
    |> User.admin_create_new_user_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.admin_user_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.admin_user_changeset(user, attrs)
  end

  alias PhxKit.Admins.Issue

  @doc """
  Returns the list of issues.

  ## Examples

      iex> list_issues()
      [%Issue{}, ...]

  """
  def list_issues do
    Repo.all(Issue)
  end

  @doc """
  Gets a single issue.

  Raises `Ecto.NoResultsError` if the Issue does not exist.

  ## Examples

      iex> get_issue!(123)
      %Issue{}

      iex> get_issue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_issue!(id), do: Repo.get!(Issue, id)

  @doc """
  Creates a issue.

  ## Examples

      iex> create_issue(%{field: value})
      {:ok, %Issue{}}

      iex> create_issue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_issue(attrs \\ %{}) do
    %Issue{}
    |> Issue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a issue.

  ## Examples

      iex> update_issue(issue, %{field: new_value})
      {:ok, %Issue{}}

      iex> update_issue(issue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_issue(%Issue{} = issue, attrs) do
    issue
    |> Issue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a issue.

  ## Examples

      iex> delete_issue(issue)
      {:ok, %Issue{}}

      iex> delete_issue(issue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_issue(%Issue{} = issue) do
    Repo.delete(issue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking issue changes.

  ## Examples

      iex> change_issue(issue)
      %Ecto.Changeset{data: %Issue{}}

  """
  def change_issue(%Issue{} = issue, attrs \\ %{}) do
    Issue.changeset(issue, attrs)
  end
end
