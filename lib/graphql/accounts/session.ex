defmodule Graphql.Accounts.Session do
  alias Graphql.{Accounts, Guardian}
  alias Graphql.Accounts.User

  def authenticate(email, password) do
    with %User{id: _user_id} = user <-
           Accounts.get_by(email: email |> String.downcase()),
         {:ok, user} <-
           Bcrypt.check_pass(user, password),
         {:ok, jwt_token, _claims} <- Guardian.encode_and_sign(user, %{}, ttl: {60, :minutes}) do
      {:ok, jwt_token, user}
    else
      nil -> {:error, "No user found"}
      {:error, _} -> {:error, "Email or password are invalid"}
    end
  end
end
