defmodule GraphqlWeb.Schema.PostType do
  @moduledoc """

    This is the Post Schema module used for GraphQL. 
    Here object type is defined. For single and multiple posts and 
    input type for post attributes.

  """

  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Graphql.Repo

  object :post do
    field :id, :string
    field :title, :string
    field :content, :string
    field :published, :boolean
    field(:user, :user, resolve: assoc(:user))
  end

  object :posts do
    field :entries, list_of(:post)
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer
  end

  input_object :post_input do
    field :title, non_null(:string)
    field :content, non_null(:string)
    field :published, non_null(:boolean)
  end

  input_object :update_post_input do
    field :title, :string
    field :content, :string
    field :published, :boolean
  end
end
