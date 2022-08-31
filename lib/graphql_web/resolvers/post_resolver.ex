defmodule GraphqlWeb.Resolvers.PostResolver do
  alias Graphql.Blog, as: Blogs
  alias GraphqlWeb.Resolvers.Utils
  alias Graphql.Accounts.User

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

  def posts(_, _, _) do
    {:ok, Blogs.list_posts()}
  end
end
