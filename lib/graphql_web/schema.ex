defmodule GraphqlWeb.Schema do
  use Absinthe.Schema

  import_types(GraphqlWeb.Schema.Types)
  alias GraphqlWeb.Resolvers.UserResolver

  query do
    @desc "Get a list of all users"
    field :users, list_of(:user) do
      resolve(&UserResolver.users/3)
    end
  end

  mutation do
    @desc "Register new user"
    field :register_user, type: :user do
      arg(:user, non_null(:user_input))
      resolve(&UserResolver.register_user/3)
    end
  end
end
