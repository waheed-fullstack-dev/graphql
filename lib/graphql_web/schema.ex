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

    @desc "Get all posts"
    field :posts, type: list_of(:post) do
      middleware(Authorize, :any)
      resolve(&PostResolver.posts/3)
    end

    @desc "Get all comments for a post"
    field :comments, type: list_of(:comment) do
      arg(:post_id, non_null(:string))
      middleware(Authorize, :any)
      resolve(&CommentResolver.comments/3)
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

    @desc "Create a new comment"
    field :create_comment, type: :comment do
      arg(:comment, non_null(:comment_input))
      middleware(Authorize, :any)
      resolve(&CommentResolver.create_comment/3)
    end
  end
end
