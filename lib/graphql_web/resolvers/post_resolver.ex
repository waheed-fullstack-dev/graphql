defmodule GraphqlWeb.Resolvers.PostResolver do
  alias Graphql.Blog, as: Blogs
  alias GraphqlWeb.Resolvers.Utils
  alias Graphql.Accounts.User
  alias Graphql.Blog.Post

  def create_post(_, args, %{context: %{current_user: %User{id: user_id}}}) do
    args = Map.put(args.post, :user_id, user_id)

    case Blogs.create_post(args) |> IO.inspect() do
      {:ok, post} ->
        {:ok, post}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}
    end
  end

  def create_post(_, _args, %{context: %{current_user: %{}}}) do
    {:error, "unauthorized"}
  end

  def posts(_, _, %{context: %{current_user: %User{id: _user_id}}}) do
    {:ok, Blogs.list_posts()}
  end

  def post(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    case Blogs.get_post(args.post_id) do
      %Post{id: _id} = post -> {:ok, post}
      nil -> {:error, "No data found"}
    end
  end

  def delete_post(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    with %Post{id: _id} = post <-
           Blogs.get_post(args.post_id) |> IO.inspect(label: "Blogs.get_post"),
         {:ok, %Post{id: _id} = post} <-
           Blogs.delete_post(post) |> IO.inspect(label: "Blogs.delete_post") do
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
