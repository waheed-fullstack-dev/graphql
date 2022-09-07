defmodule Graphql.Repo do
  use Ecto.Repo,
    otp_app: :graphql,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 10
  @moduledoc false
end
