# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Backend.Repo.insert!(%Backend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Ecto.Multi

if Mix.env() !== :test do
  Multi.new()
  |> Multi.run(:root_folder, fn _, _ -> Backend.Folders.create_root(%{name: "Root"}) end)
  |> Multi.run(:child1, fn _, %{root_folder: root_folder} ->
    Backend.Folders.add_child(%{name: "Child 1"}, root_folder.id)
  end)
  |> Multi.run(:child2, fn _, %{root_folder: root_folder} ->
    Backend.Folders.add_child(%{name: "Child 2"}, root_folder.id)
  end)
  |> Multi.run(:child11, fn _, %{child1: child1} ->
    Backend.Folders.add_child(%{name: "Child 1 1"}, child1.id)
  end)
  |> Multi.run(:child12, fn _, %{child1: child1} ->
    Backend.Folders.add_child(%{name: "Child 1 2"}, child1.id)
  end)
  |> Backend.Repo.transaction()
end
