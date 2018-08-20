defmodule RedundancyRepo.Migrations.All do
  use Ecto.Migration

  def change do
    create table(:authors) do
      add :full_name, :string
      add :email, :string
    end

    create table(:comments) do
      add :subject, :string
      add :content, :string
      add :author_id, :integer
      add :post_id, :integer
    end

    create table(:posts) do
      add :title, :string
      add :body, :string
    end
  end
end
