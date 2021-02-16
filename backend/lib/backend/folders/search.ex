defmodule Backend.Folders.Search do
  alias Backend.Folders
  alias Backend.Folders.Folder

  def search(name) do
    Folders.list_folders(name)
    |> Enum.map(fn folder -> [folder | Folder.ancestors(folder)] end)
    |> Enum.flat_map(fn folder -> folder end)
    |> Enum.uniq_by(fn folder -> folder.id end)
  end
end
