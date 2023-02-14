defmodule PhxKit.AdminsTest do
  use PhxKit.DataCase

  alias PhxKit.Admins

  describe "users" do
    alias PhxKit.Admins.User

    import PhxKit.AdminsFixtures

    @invalid_attrs %{confirmed_at: nil, email: nil, hashed_password: nil, name: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Admins.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Admins.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{confirmed_at: ~N[2023-02-12 23:50:00], email: "some email", hashed_password: "some hashed_password", name: "some name"}

      assert {:ok, %User{} = user} = Admins.create_user(valid_attrs)
      assert user.confirmed_at == ~N[2023-02-12 23:50:00]
      assert user.email == "some email"
      assert user.hashed_password == "some hashed_password"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Admins.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{confirmed_at: ~N[2023-02-13 23:50:00], email: "some updated email", hashed_password: "some updated hashed_password", name: "some updated name"}

      assert {:ok, %User{} = user} = Admins.update_user(user, update_attrs)
      assert user.confirmed_at == ~N[2023-02-13 23:50:00]
      assert user.email == "some updated email"
      assert user.hashed_password == "some updated hashed_password"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Admins.update_user(user, @invalid_attrs)
      assert user == Admins.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Admins.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Admins.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Admins.change_user(user)
    end
  end
end
