defmodule GraphqlWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias GraphqlWeb.Schema.UserType

  import_types(UserType)
end
