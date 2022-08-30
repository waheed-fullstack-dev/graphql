defmodule Graphql.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Graphql.Accounts.User

  @required_fields ~w|
  
    content
    title
    user_id
  
  |a

  @optional_fields ~w|

    published


  |a

  @all_fields @required_fields ++ @optional_fields

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "posts" do
    field :title, :string
    field :content, :string
    field :published, :boolean, default: false
    belongs_to(:user, User)

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, @all_fields)
    |> validate_required(@required_fields)
  end
end
