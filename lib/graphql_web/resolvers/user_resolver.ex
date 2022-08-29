defmodule GraphqlWeb.Resolvers.UserResolver do
  alias Graphql.Accounts

  def users(_, _, _) do
    {:ok, Accounts.list_users()}
  end

  def register_user(_, %{user: user}, _) do
    case Accounts.create_user(user) |> IO.inspect(label: "create_user@9") do
      {:ok, user} ->
        {:ok, user}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, get_changeset_error_message(changeset)}

      _ ->
        {:error, "Could not create new user"}
    end
  end

  defp get_changeset_error_message(%Ecto.Changeset{} = changeset) do
    # password_confirmation error message
    password_error = Keyword.get(changeset.errors, :password, nil)
    errors =
      if is_nil(password_error) do
        []
      else
        {_, list} = password_error

        cond do
          list[:validation] == :required -> ["Password can't be blank"]
          list[:validation] == :length -> ["Password should be between 6 to 20 alphabets"]
          true -> ["Invalid password"]
        end
      end

    # password_confirmation error message
    password_confirmation_error = Keyword.get(changeset.errors, :password_confirmation, nil)
    errors =
      if is_nil(password_confirmation_error) do
        errors
      else
        {_, list} = password_confirmation_error

        res = cond do
          list[:validation] == :confirmation -> ["Confirm password does not match"]
          list[:validation] == :format -> ["Something went wrong"]
          true -> ["Invalid confirm password"]
        end
        errors ++ res
      end

    # email error message
    email_error = Keyword.get(changeset.errors, :email, nil)

    errors =
      if is_nil(email_error) do
        errors
      else
        {_, list} = email_error

        res = cond do
          list[:validation] == :unsafe_unique -> ["Email has been already taken"]
          list[:validation] == :format -> ["Email must have the @ sign and no spaces"]
          list[:constraint] == :unique -> ["Email has been already taken"]
          true -> ["Invalid email"]
        end

        errors ++ res
      end

    # email error message
    first_name_error = Keyword.get(changeset.errors, :first_name, nil)

    errors =
      if is_nil(first_name_error) do
        errors
      else
        {_, list} = first_name_error

        res = cond do
          list[:validation] == :required  -> ["First name can't be empty"]
          list[:validation] == :length -> ["First name should be between 3 to 20 characters"]
          true -> ["Invalid first name"]
        end

        errors ++ res
      end

    # email error message
    last_name_error = Keyword.get(changeset.errors, :last_name, nil)

    _errors =
      if is_nil(last_name_error) do
        errors
      else
        {_, list} = last_name_error

        res = cond do
          list[:validation] == :required  -> ["Last name can't be empty"]
          list[:validation] == :length -> ["Last name should be between 3 to 20 characters"]
          true -> ["Invalid last name"]
        end

        errors ++ res
      end
  end
end
