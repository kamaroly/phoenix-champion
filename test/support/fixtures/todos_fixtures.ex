defmodule Champions.TodosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Champions.Todos` context.
  """

  @doc """
  Generate a todo.
  """
  def todo_fixture(attrs \\ %{}) do
    {:ok, todo} =
      attrs
      |> Enum.into(%{
        name: "some name",
        done: true
      })
      |> Champions.Todos.create_todo()

    todo
  end
end
