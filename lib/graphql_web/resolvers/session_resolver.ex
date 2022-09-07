defmodule GraphqlWeb.Resolvers.SessionResolver do
  @moduledoc """

    This is the Session Resolver module. Here we check user is valid or not 
    when login operation is performed.

  """

  alias Graphql.Accounts.Session

  def login_user(_, args, _) do
    case Session.authenticate(args.login.email, args.login.password) do
      {:ok, jwt_token, user} -> {:ok, %{token: jwt_token, user: user}}
      {:error, reason} -> {:error, reason}
    end
  end
end
