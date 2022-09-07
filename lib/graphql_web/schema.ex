defmodule GraphqlWeb.Schema do
  @moduledoc false
  use Absinthe.Schema

  # Import all schema types that are being used in query and mutation
  import_types(GraphqlWeb.Schema.Types)

  # Resolvers for each module
  alias GraphqlWeb.Resolvers.{UserResolver, SessionResolver, PostResolver, CommentResolver}
  # Authorization for routing
  alias GraphqlWeb.Schema.Middleware.Authorize

  query do
    @desc "Get a list of all users"
    field :users, :users do
      arg(:limit, :integer, default_value: 10)
      arg(:page, :integer, default_value: 1)
      middleware(Authorize, :any)
      resolve(&UserResolver.users/3)
    end

    @desc "Get a user by user_id"
    field :user, :user do
      arg(:user_id, non_null(:id))
      middleware(Authorize, :any)
      resolve(&UserResolver.user/3)
    end

    @desc "Get all posts"
    field :posts, type: :posts do
      arg(:limit, :integer, default_value: 10)
      arg(:page, :integer, default_value: 1)
      middleware(Authorize, :any)
      resolve(&PostResolver.posts/3)
    end

    @desc "Get post by id"
    field :post, type: :post do
      arg(:post_id, non_null(:id))
      middleware(Authorize, :any)
      resolve(&PostResolver.post/3)
    end

    @desc "Get all comments"
    field :comments, type: :comments do
      arg(:limit, :integer, default_value: 10)
      arg(:page, :integer, default_value: 1)
      middleware(Authorize, :any)
      resolve(&CommentResolver.comments/3)
    end

    @desc "Get comment by id"
    field :comment, type: :comment do
      arg(:comment_id, non_null(:id))
      middleware(Authorize, :any)
      resolve(&CommentResolver.comment/3)
    end

    @desc "Get all comments for a post"
    field :post_comments, type: list_of(:comment) do
      arg(:post_id, non_null(:id))
      middleware(Authorize, :any)
      resolve(&CommentResolver.get_post_comments/3)
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

    @desc "Update user"
    field :update_user, type: :user do
      arg(:user_id, non_null(:id))
      arg(:user, non_null(:update_user_input))
      resolve(&UserResolver.update_user/3)
    end

    @desc "Create a new post"
    field :create_post, type: :post do
      arg(:post, non_null(:post_input))
      middleware(Authorize, :any)
      resolve(&PostResolver.create_post/3)
    end

    @desc "Delete post"
    field :delete_post, type: :post do
      arg(:post_id, non_null(:id))
      middleware(Authorize, :any)
      resolve(&PostResolver.delete_post/3)
    end

    @desc "Update post"
    field :update_post, type: :post do
      arg(:post_id, non_null(:id))
      arg(:post, non_null(:update_post_input))
      middleware(Authorize, :any)
      resolve(&PostResolver.update_post/3)
    end

    @desc "Create a new comment"
    field :create_comment, type: :comment do
      arg(:comment, non_null(:comment_input))
      middleware(Authorize, :any)
      resolve(&CommentResolver.create_comment/3)
    end

    @desc "Delete comment"
    field :delete_comment, type: :comment do
      arg(:comment_id, non_null(:id))
      middleware(Authorize, :any)
      resolve(&CommentResolver.delete_comment/3)
    end

    @desc "Update comment"
    field :update_comment, type: :comment do
      arg(:comment_id, non_null(:id))
      arg(:comment, non_null(:comment_input))
      middleware(Authorize, :any)
      resolve(&CommentResolver.update_comment/3)
    end
  end
end
