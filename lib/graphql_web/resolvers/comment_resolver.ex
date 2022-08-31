defmodule GraphqlWeb.Resolvers.CommentResolver do
  alias Graphql.Blog, as: Blogs
  alias GraphqlWeb.Resolvers.Utils
  alias Graphql.Accounts.User
  alias Graphql.Blog.Comment

  # Create new comment only if current user found
  def create_comment(_, args, %{context: %{current_user: %User{id: user_id}}}) do
    args = Map.put(args.comment, :user_id, user_id)

    case Blogs.create_comment(args) |> IO.inspect() do
      {:ok, comment} ->
        {:ok, comment}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}
    end
  end

  # Return comments 
  def comments(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    limit = if Map.has_key?(args, :limit), do: args.limit, else: 20
    page = if Map.has_key?(args, :page), do: args.page, else: 0

    {:ok, Blogs.get_pagination_list_comments(limit, page)}
  end

  # Return comment 
  def comment(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    case Blogs.get_comment(args.comment_id) do
      %Comment{id: _id} = comment -> {:ok, comment}
      nil -> {:error, "No data found"}
    end
  end

  def get_post_comments(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    {:ok, Blogs.list_post_comments(args.post_id)}
  end

  def delete_comment(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    with %Comment{id: _id} = comment <- Blogs.get_comment(args.comment_id),
         {:ok, %Comment{id: _id} = comment} <- Blogs.delete_comment(comment) do
      {:ok, comment}
    else
      nil ->
        {:error, "No data found to detele"}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}
    end
  end

  # Update comments  
  def update_comment(_, args, %{context: %{current_user: %User{id: user_id}}}) do
    comments = Map.put(args.comment, :user_id, user_id)

    with %Comment{id: _id} = comment <- Blogs.get_comment(args.comment_id),
         {:ok, %Comment{id: _id} = comment} <- Blogs.update_comment(comment, comments) do
      {:ok, comment}
    else
      nil ->
        {:error, "No data found to update"}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}
    end
  end
end
