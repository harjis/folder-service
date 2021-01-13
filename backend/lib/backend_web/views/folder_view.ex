defmodule BackendWeb.FolderView do
  use BackendWeb, :view
  alias BackendWeb.FolderView

  def render("index.json", %{folders: folders}) do
    render_many(folders, FolderView, "folder.json")
  end

  def render("show.json", %{folder: folder}) do
    render_one(folder, FolderView, "folder.json")
  end

  def render("folder.json", %{folder: folder}) do
    %{id: folder.id, name: folder.name}
  end
end
