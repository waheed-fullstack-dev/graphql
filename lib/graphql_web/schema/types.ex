defmodule GraphqlWeb.Schema.Types do
  @moduledoc """

    This is the Types module used for GraphQL. 
    Here all object types are combined to used in GraphQL Schema. 

  """

  use Absinthe.Schema.Notation

  alias GraphqlWeb.Schema.{UserType, SessionType, PostType, CommentType}

  import_types(UserType)
  import_types(SessionType)
  import_types(PostType)
  import_types(CommentType)
end
