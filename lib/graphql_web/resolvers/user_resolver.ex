defmodule GraphqlWeb.Resolvers.UserResolver do
  alias Graphql.Accounts
  alias GraphqlWeb.Resolvers.Utils

  def users(_, _, %{context: context}) do
    IO.inspect(context)
    {:ok, Accounts.list_users()}
  end

  def register_user(_, %{user: user}, _) do
    case Accounts.create_user(user) |> IO.inspect(label: "create_user@9") do
      {:ok, user} ->
        {:ok, user}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}

      _ ->
        {:error, "Could not create new user"}
    end
  end
end
