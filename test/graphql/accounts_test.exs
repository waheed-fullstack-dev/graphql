defmodule Graphql.AccountsTest do
  use Graphql.DataCase

  alias Graphql.Accounts

  describe "users" do
    alias Graphql.Accounts.User

    import Graphql.AccountsFixtures

    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, role: nil}

    test "list_users/0 returns all users" do
      {:ok, user} = user_fixture() |> Accounts.create_user()

      user = Map.merge(user, %{password: nil, password_confirmation: nil})
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      {:ok, user} = user_fixture() |> Accounts.create_user()

      user = Map.merge(user, %{password: nil, password_confirmation: nil})
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      password = Faker.Random.Elixir.random_bytes(8)

      valid_attrs = %{
        email: "itsswaheed@gmail.com",
        first_name: "Mohammad",
        password: password,
        password_confirmation: password,
        last_name: "Waheed",
        role: "user"
      }

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.email == valid_attrs.email
      assert user.first_name == valid_attrs.first_name
      assert user.last_name == valid_attrs.last_name
      assert user.role == valid_attrs.role
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      {:ok, user} = user_fixture() |> Accounts.create_user()

      update_attrs = %{
        first_name: Faker.Person.first_name(),
        last_name: Faker.Person.last_name(),
        email: Faker.Internet.email(),
        role: "user"
      }

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.email == update_attrs.email
      assert user.first_name == update_attrs.first_name
      assert user.last_name == update_attrs.last_name
      assert user.role == update_attrs.role
    end

    test "update_user/2 with invalid data returns error changeset" do
      {:ok, user} = user_fixture() |> Accounts.create_user()
      user = Map.merge(user, %{password: nil, password_confirmation: nil})
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      {:ok, user} = user_fixture() |> Accounts.create_user()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      {:ok, user} = user_fixture() |> Accounts.create_user()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
