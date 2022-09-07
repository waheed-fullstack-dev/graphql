defmodule GraphqlWeb.Schema.UserType do
  @moduledoc """

    This is the User Schema module used for GraphQL. 
    Here object type is defined. For single and multiple users and 
    input type for user attributes.

  """
  use Absinthe.Schema.Notation

  object :user do
    field :id, :id
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :role, :string
  end

  object :users do
    field :entries, list_of(:user)
    field :page_number, :integer
    field :page_size, :integer
    field :total_entries, :integer
    field :total_pages, :integer
  end

  input_object :user_input do
    field :first_name, non_null(:string)
    field :last_name, non_null(:string)
    field :email, non_null(:string)
    field :password, non_null(:string)
    field :password_confirmation, non_null(:string)
  end

  input_object :update_user_input do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
  end
end
