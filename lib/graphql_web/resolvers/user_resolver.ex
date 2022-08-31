defmodule GraphqlWeb.Resolvers.UserResolver do
  alias Graphql.Accounts
  alias Graphql.Accounts.User
  alias GraphqlWeb.Resolvers.Utils

  def users(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    limit = if Map.has_key?(args, :limit), do: args.limit, else: 20
    page = if Map.has_key?(args, :page), do: args.page, else: 1
    {:ok, Accounts.get_paginate_list_users(limit, page)}
  end

  def register_user(_, %{user: user}, _) do
    case Accounts.create_user(user) do
      {:ok, user} ->
        {:ok, user}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}

      _ ->
        {:error, "Could not create new user"}
    end
  end

  def user(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    case Accounts.get_user(args.user_id) do
      %User{id: _id} = user -> {:ok, user}
      nil -> {:error, "No data found"}
    end
  end

  def update_user(_, args, %{context: %{current_user: %User{id: _user_id}}}) do
    users = args.user
    with %User{id: _id} = user <- Accounts.get_user(args.user_id),
         {:ok, %User{id: _id} = user} <- Accounts.update_user(user, users) do
      {:ok, user}
    else
      nil ->
        {:error, "No data found to update"}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, Utils.get_changeset_error_message(changeset)}
    end
  end
end
