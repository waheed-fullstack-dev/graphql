defmodule Graphql.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w|

    email
    first_name
    last_name
    password
    password_confirmation
    
  |a

  @optional_fields ~w|
    role
  |a

  @all_fields @required_fields ++ @optional_fields

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:password_hash, :string)
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
    |> validate_required(@required_fields, trim: true)
    |> validate_format(:email, ~r/@/, message: "must have the @ sign and no spaces")
    |> update_change(:email, &String.downcase(&1))
    |> validate_length(:password, min: 6, max: 20, message: "must be between 6 to 20 alphabets")
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> hash_password
  end

  @doc false
  def update_changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :first_name, :last_name])
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, &String.downcase(&1))
    |> unique_constraint(:email)
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp hash_password(changeset) do
    changeset
  end
end
