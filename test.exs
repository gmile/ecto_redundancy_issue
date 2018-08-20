use Mix.Config

config :comments_test, ecto_repos: [Contractbook.Domain.Repo]

defmodule Repo do
  use Ecto.Repo, otp_app: :comments_test
end

defmodule Author do
  use Ecto.Schema

  schema "authors" do
    field :full_name, :string
    field :email, :string
  end
end

defmodule Comment do
  use Ecto.Schema

  schema "comments" do
    field :subject, :string
    field :content, :string

    belongs_to :author, Author
  end
end

defmodule Post do
  use Ecto.Schema

  schema "posts" do
    field :title, :string
    field :body, :string

    has_many :comments, Comment
    has_many :commenters, through: [:comments, :author]
  end
end

Repo.all(Comment)
