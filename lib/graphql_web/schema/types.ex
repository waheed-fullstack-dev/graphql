defmodule GraphqlWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias GraphqlWeb.Schema.{UserType, SessionType, PostType}

  import_types(UserType)
  import_types(SessionType)
  import_types(PostType)
end
