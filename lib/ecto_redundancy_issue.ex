defmodule RedundancyRepo do
  use Ecto.Repo, otp_app: :ecto_redundancy_issue
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
    field :post_id, :integer

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

defmodule Issue do
  import Ecto.Query

  def insert_fixtures do
    RedundancyRepo.delete_all("posts")
    RedundancyRepo.delete_all("authors")
    RedundancyRepo.delete_all("comments")

    RedundancyRepo.insert_all("posts", [
      %{id: 1, title: "My title", body: "My body"}
    ])

    RedundancyRepo.insert_all("authors", [
      %{id: 1, full_name: "Full name 1", email: "client1@server.com"},
      %{id: 2, full_name: "Full name 2", email: "client2@server.com"},
      %{id: 3, full_name: "Full name 3", email: "client3@server.com"}
    ])

    RedundancyRepo.insert_all("comments", [
      %{id: 1, post_id: 1, author_id: 1, subject: "Subject 1", content: "Big content 1"},
      %{id: 2, post_id: 1, author_id: 2, subject: "Subject 2", content: "Big content 2"},
      %{id: 3, post_id: 1, author_id: 3, subject: "Subject 3", content: "Big content 3"},
      %{id: 4, post_id: 1, author_id: 1, subject: "Subject 4", content: "Big content 4"},
      %{id: 5, post_id: 1, author_id: 2, subject: "Subject 5", content: "Big content 5"},
      %{id: 6, post_id: 1, author_id: 3, subject: "Subject 6", content: "Big content 6"}
    ])
  end

  def test do
    commenter_emails_query = from a in Author, select: struct(a, [:email])

    posts_query = from p in Post, preload: [commenters: ^commenter_emails_query]

    RedundancyRepo.all(posts_query)
  end
end
