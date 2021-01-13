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

Multi.new()
|> Multi.run(:folder_1, fn _, _ -> Backend.Folders.create_folder(%{name: "Folder 1"}) end)
|> Multi.run(:folder_2, fn _, _ -> Backend.Folders.create_folder(%{name: "Folder 2"}) end)
|> Multi.run(:folder_3, fn _, _ -> Backend.Folders.create_folder(%{name: "Folder 3"}) end)
|> Multi.run(:folder_4, fn _, _ -> Backend.Folders.create_folder(%{name: "Folder 4"}) end)
|> Multi.run(:folder_5, fn _, _ -> Backend.Folders.create_folder(%{name: "Folder 5"}) end)
|> Backend.Repo.transaction()
