defmodule Graphql.BlogFixtures do
  alias Graphql.Accounts
  alias Graphql.Accounts.User
  alias Graphql.Blog.Post
  alias Graphql.Blog
  import Graphql.AccountsFixtures

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Graphql.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, %User{} = user} = user_fixture() |> Accounts.create_user()

    attrs
    |> Enum.into(%{
      content: Faker.Lorem.sentence(20, "..."),
      published: true,
      title: Faker.Person.title(),
      user_id: user.id
    })
  end

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    {:ok, user} = user_fixture() |> Accounts.create_user()
    {:ok, %Post{} = post} = post_fixture() |> Blog.create_post()

    attrs
    |> Enum.into(%{
      content: Faker.Lorem.sentence(20, "..."),
      user_id: user.id,
      post_id: post.id
    })
  end
end
