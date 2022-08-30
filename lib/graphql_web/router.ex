defmodule GraphqlWeb.Router do
  use GraphqlWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug(GraphqlWeb.Plugs.Context)
  end

  scope "/api" do
    pipe_through :api

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: GraphqlWeb.Schema)
  end
end
