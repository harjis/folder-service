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
    %{
      id: folder.id,
      insertedAt: folder.inserted_at,
      lft: folder.lft,
      name: folder.name,
      parentId: folder.parent_id,
      rgt: folder.rgt,
      updatedAt: folder.updated_at
    }
  end
end
