defmodule Graphql.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Graphql.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        published: true,
        title: "some title"
      })
      |> Graphql.Blog.create_post()

    post
  end
end
