defmodule Graphql.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :first_name, :string
    field :hash_password, :string
    field :last_name, :string
    field :role, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :hash_password, :role])
    |> validate_required([:first_name, :last_name, :email, :hash_password, :role])
  end
end
