defmodule GraphqlWeb.Schema.SessionType do
  @moduledoc """

    This is the Session Schema module used for GraphQL. 
    Here object type is defined. 

  """
  use Absinthe.Schema.Notation

  object :login do
    field :token, :string
    field :user, :user
  end

  input_object :login_input do
    field :email, non_null(:string)
    field :password, non_null(:string)
  end
end
