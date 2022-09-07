defmodule GraphqlWeb.Schema.CommentType do
  @moduledoc """

    This is the Comment Schema module used for GraphQL. 
    Here object type is defined. For single and multiple comments and 
    input type for comments attributes.

  """

  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Graphql.Repo

  object :comment do
    field :id, :string
    field :content, :string
    field(:user, :user, resolve: assoc(:user))
    field(:post, :post, resolve: assoc(:post))
  end

  object :comments do
    field :entries, list_of(:comment)
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer
  end

  input_object :comment_input do
    field :content, non_null(:string)
    field :post_id, non_null(:id)
  end
end
