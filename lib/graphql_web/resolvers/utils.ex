defmodule GraphqlWeb.Resolvers.Utils do
  def get_changeset_error_message(%Ecto.Changeset{} = changeset) do
    # Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
    #   Regex.replace(~r"%{(\w+)}", message, fn _, key ->
    #     opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string() 
    #   end) 
    # end)

    errors = changeset.errors

    Enum.reduce(Keyword.keys(errors), [], fn key, acc ->
      case Keyword.get(errors, key, nil) do
        {message, _} -> [Atom.to_string(key) <> " " <> message] ++ acc
        nil -> acc
      end
    end)
  end
end
