defmodule GraphqlWeb.Router do
  use GraphqlWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: GraphqlWeb.Schema)
  end
end
