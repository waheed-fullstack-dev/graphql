defmodule Graphql.BlogFixtures do
  alias Graphql.Blog.{Post, Comment}
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
    user = user_fixture()

    {:ok, %Post{} = post} =
      attrs
      |> Enum.into(%{
        content: Faker.Lorem.sentence(20, "..."),
        published: true,
        title: Faker.Person.title(),
        user_id: user.id
      })
      |> Blog.create_post()

    post
  end

  @doc """
  Generate a comment.
  """
  def comment_fixture(attrs \\ %{}) do
    user = user_fixture()
    post = post_fixture()

    {:ok, %Comment{} = comment} =
      attrs
      |> Enum.into(%{
        content: Faker.Lorem.sentence(20, "..."),
        user_id: user.id,
        post_id: post.id
      })
      |> Blog.create_comment()

    comment
  end
end
