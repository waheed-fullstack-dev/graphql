defmodule Graphql.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w|

    email
    first_name
    password
    password_confirmation

  |a

  @optional_fields ~w|

    last_name
    role

  |a

  @all_fields @required_fields ++ @optional_fields

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:hash_password, :string)
    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)
    field(:last_name, :string)
    field(:role, :string, default: "user")

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 20)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> hash_password
  end

  defp hash_password(changeset) do
    changeset
  end
end
