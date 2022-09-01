defmodule Graphql.Factory do
  use ExMachina.Ecto, repo: Graphql.Repo
  use Graphql.UserFactory
end
