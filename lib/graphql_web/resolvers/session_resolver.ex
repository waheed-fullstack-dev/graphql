defmodule GraphqlWeb.Resolvers.SessionResolver do
  alias Graphql.Accounts.Session

  def login_user(_, args, _) do
    with {:ok, jwt_token, user} <- Session.authenticate(args.login.email, args.login.password) do
      {:ok, %{token: jwt_token, user: user}}
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
