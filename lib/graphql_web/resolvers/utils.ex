defmodule GraphqlWeb.Resolvers.Utils do
  def get_changeset_error_message(%Ecto.Changeset{} = changeset) do
    errors = changeset.errors
    Enum.reduce(Keyword.keys(errors), [], fn  key, acc -> 
      case Keyword.get(errors, key, nil) do
        {message, _} -> [Atom.to_string(key)<> " " <> message] ++ acc
        nil -> acc
      end
    end)
  end
end
