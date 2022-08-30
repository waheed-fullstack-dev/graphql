defmodule GraphqlWeb.Plugs.Context do
  @behavior Plug
  import Plug.Conn

  alias Graphql.Guardian

  def init(default), do: default

  def call(conn, _) do
    res = with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
        {:ok, claims} <- Guardian.decode_and_verify(token),
        {:ok, user} <- Guardian.resource_from_claims(claims) do
      %{current_user: user}
    else
      _ -> %{}
    end

    Absinthe.Plug.put_options(conn, context: res)
  end
end
