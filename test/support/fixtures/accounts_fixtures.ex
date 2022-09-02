defmodule Graphql.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Graphql.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    password = Faker.Random.Elixir.random_bytes(8)

    attrs
    |> Enum.into(%{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      email: Faker.Internet.free_email(),
      password: password,
      password_confirmation: password,
      role: "user"
    })
  end
end
