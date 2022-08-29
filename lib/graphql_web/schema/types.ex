defmodule Graphql.Schema.Types do
use Absinthe.Schema.Notation

alias Graphql.Schema.Types

import_types(Types.UserType)
end