defmodule Graphql.BlogTest do
  use Graphql.DataCase

  alias Graphql.Blog
  import Graphql.AccountsFixtures
  import Graphql.BlogFixtures

  describe "posts" do
    alias Graphql.Blog.Post

    @invalid_attrs %{content: nil, published: nil, title: nil, user_id: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()

      assert Blog.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Blog.get_post(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      user = user_fixture()

      valid_attrs = %{
        content: Faker.Lorem.sentence(20, "..."),
        published: true,
        title: Faker.Person.title(),
        user_id: user.id
      }

      assert {:ok, %Post{} = post} = Blog.create_post(valid_attrs)
      assert post.content == valid_attrs.content
      assert post.published == valid_attrs.published
      assert post.title == valid_attrs.title
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()

      update_attrs = %{
        content: Faker.Lorem.sentence(10, "..."),
        published: false,
        title: Faker.Person.title()
      }

      assert {:ok, %Post{} = post} = Blog.update_post(post, update_attrs)
      assert post.content == update_attrs.content
      assert post.published == false
      assert post.title == update_attrs.title
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_post(post, @invalid_attrs)
      assert post == Blog.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Blog.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Blog.change_post(post)
    end
  end

  describe "comments" do
    alias Graphql.Blog.Comment

    @invalid_attrs %{content: nil, user_id: nil, post_id: nil}

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Blog.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Blog.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      user = user_fixture()
      post = post_fixture()

      valid_attrs = %{
        content: Faker.Lorem.sentence(20, "..."),
        user_id: user.id,
        post_id: post.id
      }

      assert {:ok, %Comment{} = comment} = Blog.create_comment(valid_attrs)
      assert comment.content == valid_attrs.content
      assert comment.post_id == valid_attrs.post_id
      assert comment.user_id == valid_attrs.user_id
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Blog.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      update_attrs = %{content: Faker.Lorem.sentence(20, "...")}

      assert {:ok, %Comment{} = comment} = Blog.update_comment(comment, update_attrs)
      assert comment.content == update_attrs.content
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Blog.update_comment(comment, @invalid_attrs)
      assert comment == Blog.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Blog.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Blog.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Blog.change_comment(comment)
    end
  end
end
