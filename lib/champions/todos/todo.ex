defmodule Champions.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :name, :string
    field :done, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:name, :done])
    |> validate_required([:name, :done])
  end

  def mark_as_done_changeset(todo, attrs) do
    todo
      |> cast(attrs, [:done])
      |> validate_required([:done])
  end
end
