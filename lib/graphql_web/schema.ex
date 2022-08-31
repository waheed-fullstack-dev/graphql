defmodule GraphqlWeb.Schema do
  use Absinthe.Schema

  import_types(GraphqlWeb.Schema.Types)
  alias GraphqlWeb.Resolvers.{UserResolver, SessionResolver, PostResolver, CommentResolver}
  alias GraphqlWeb.Schema.Middleware.Authorize

  query do
    @desc "Get a list of all users"
    field :users, list_of(:user) do
      middleware(Authorize, :any)
      resolve(&UserResolver.users/3)
    end
  end

  mutation do
    @desc "Register new user"
    field :register_user, type: :user do
      arg(:user, non_null(:user_input))
      resolve(&UserResolver.register_user/3)
    end

    @desc "Login user and return JWT token"
    field :login, type: :login do
      arg(:login, non_null(:login_input))
      resolve(&SessionResolver.login_user/3)
    end

    @desc "Create a new post"
    field :create_post, type: :post do
      arg(:post, non_null(:post_input))
      middleware(Authorize, :any)
      resolve(&PostResolver.create_post/3)
    end

    @desc "Create a new post"
    field :create_comment, type: :comment do
      arg(:comment, non_null(:comment_input))
      middleware(Authorize, :any)
      resolve(&CommentResolver.create_post/3)
    end

    @desc "Get all posts"
    field :posts, type: :post do
      arg(:post, non_null(:post_input))
      middleware(Authorize, :any)
      resolve(&PostResolver.create_post/3)
    end
  end
end
