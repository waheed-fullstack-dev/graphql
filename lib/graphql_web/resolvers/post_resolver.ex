defmodule GraphqlWeb.Resolvers.PostResolver do
  alias Graphql.Blog, as: Blogs
  alias GraphqlWeb.Resolvers.Utils
  alias Graphql.Accounts.User
  alias Graphql.Blog.Post

  def create_post(_, args, %{context: %{current_user: %User{id: user_id}}}) do
    args = Map.put(args.post, :user_id, user_id)

    case Blogs.create_post(args) do
      {:ok, post} ->
        {:ok, post}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}
    end
  end

  def posts(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    limit = if Map.has_key?(args, :limit), do: args.limit, else: 20
    page = if Map.has_key?(args, :page), do: args.page, else: 1

    {:ok, Blogs.get_pagination_list_posts(limit, page)}
  end

  def post(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    case Blogs.get_post(args.post_id) do
      %Post{id: _id} = post -> {:ok, post}
      nil -> {:error, "No data found"}
    end
  end

  def delete_post(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    with %Post{id: _id} = post <-
           Blogs.get_post(args.post_id),
         {:ok, %Post{id: _id} = post} <-
           Blogs.delete_post(post) do
      {:ok, post}
    else
      nil ->
        {:error, "No data found to detele"}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}
    end
  end

  def update_post(_, args, %{context: %{current_user: %User{id: user_id}}}) do
    posts = Map.put(args.post, :user_id, user_id)

    with %Post{id: _id} = post <- Blogs.get_post(args.post_id),
         {:ok, %Post{id: _id} = post} <- Blogs.update_post(post, posts) do
      {:ok, post}
    else
      nil ->
        {:error, "No data found to update"}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}
    end
  end
end
