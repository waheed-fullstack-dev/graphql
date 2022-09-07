defmodule Graphql.BlogFixtures do
  alias Graphql.Blog.{Post, Comment}
  alias Graphql.Blog

  @moduledoc """
  This module defines test helpers for creating
  entities via the `Graphql.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(user_id, attrs \\ %{}) do
    {:ok, %Post{} = post} =
      attrs
      |> Enum.into(%{
        content: Faker.Lorem.sentence(20, "..."),
        published: true,
        title: Faker.Person.title(),
        user_id: user_id
      })
      |> Blog.create_post()

    post
  end

  @doc """
  Generate a comment.
  """
  def comment_fixture(post_id, user_id, attrs \\ %{}) do
    {:ok, %Comment{} = comment} =
      attrs
      |> Enum.into(%{
        content: Faker.Lorem.sentence(20, "..."),
        user_id: user_id,
        post_id: post_id
      })
      |> Blog.create_comment()

    comment
  end
end
