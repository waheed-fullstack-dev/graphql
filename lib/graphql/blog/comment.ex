defmodule Graphql.Blog.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Graphql.Accounts.User
  alias Graphql.Blog.Post

  @required_fields ~w|
  
    content
    post_id
    user_id
  
  |a

  @optional_fields ~w|


  |a

  @all_fields @required_fields ++ @optional_fields

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :content, :string
    belongs_to(:user, User)
    belongs_to(:post, Post)

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
  end
end
