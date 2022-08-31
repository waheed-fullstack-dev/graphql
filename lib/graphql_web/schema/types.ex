defmodule GraphqlWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias GraphqlWeb.Schema.{UserType, SessionType, PostType, CommentType}

  import_types(UserType)
  import_types(SessionType)
  import_types(PostType)
  import_types(CommentType)
end
