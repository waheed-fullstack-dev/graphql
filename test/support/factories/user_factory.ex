defmodule Graphql.UserFactory do
  alias Graphql.Accounts.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          first_name: Faker.Person.first_name(),
          last_name: Faker.Person.last_name(),
          email: Faker.Internet.email(),
          password: Faker.Random.random_bytes(8),
          password_confirmation: Faker.Random.random_bytes(8)
        }
      end
    end
  end
end
