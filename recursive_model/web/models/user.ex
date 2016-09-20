defmodule RecursiveModel.User do
  alias RecursiveModel.Repo

  use RecursiveModel.Web, :model
  use RecursiveModel.RecursionTransversal, repo: Repo

  schema "users" do
    field :name, :string
    belongs_to :parent, RecursiveModel.User, foreign_key: :parent_id
    has_many :children, RecursiveModel.User, foreign_key: :parent_id
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
