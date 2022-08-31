defmodule GraphqlWeb.Resolvers.CommentResolver do
  alias Graphql.Blog, as: Blogs
  alias GraphqlWeb.Resolvers.Utils
  alias Graphql.Accounts.User

  def create_comment(_, args, %{context: %{current_user: %User{id: user_id}}}) do
    args = Map.put(args.comment, :user_id, user_id)

    case Blogs.create_comment(args) |> IO.inspect() do
      {:ok, comment} ->
        {:ok, comment}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}
    end
  end

  def create_comment(_, _args, %{context: %{current_user: %{}}}) do
    {:error, "unauthorized"}
  end

  def comments(_, args, _) do
    {:ok, Blogs.list_post_comments(args.post_id)}
  end
end
