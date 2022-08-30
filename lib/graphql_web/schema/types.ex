defmodule GraphqlWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias GraphqlWeb.Schema.{UserType, SessionType}

  import_types(UserType)
  import_types(SessionType)
end
