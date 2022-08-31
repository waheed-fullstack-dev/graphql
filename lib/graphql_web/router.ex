defmodule GraphqlWeb.Router do
  use GraphqlWeb, :router

  # added plug to check authorization header and add current login user
  pipeline :api do
    plug :accepts, ["json"]
    plug(GraphqlWeb.Plugs.Context)
  end

  scope "/api" do
    pipe_through :api

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: GraphqlWeb.Schema)
  end
end
