defmodule GraphqlWeb.Schema.Middleware.Authorize do
  @moduledoc """

    This is the authorization middleware used for GraphQL routes.

  """

  @behaviour Absinthe.Middleware

  def call(resolution, role) do
    with %{current_user: user} <- resolution.context,
         true <- correct_role?(user, role) do
      resolution
    else
      _ -> resolution |> Absinthe.Resolution.put_result({:error, "unauthenticated"})
    end
  end

  defp correct_role?(%{}, :any), do: true
  defp correct_role?(%{role: role}, role), do: true
  defp correct_role?(_, _), do: false
end
