defmodule BackendWeb.FolderController do
  use BackendWeb, :controller

  alias Backend.Folders
  alias Backend.Folders.Folder

  action_fallback BackendWeb.FallbackController

  def roots(conn, _params) do
    roots = Folders.list_roots()
    render(conn, "index.json", folders: roots)
  end

  def children(conn, %{"parent_id" => parent_id}) do
    children = Folders.list_children(parent_id)
    render(conn, "index.json", folders: children)
  end

  def show(conn, %{"id" => id}) do
    folder = Folders.get_folder!(id)
    render(conn, "show.json", folder: folder)
  end

  def update(conn, %{"id" => id, "folder" => folder_params}) do
    folder = Folders.get_folder!(id)

    with {:ok, %Folder{} = folder} <- Folders.update_folder(folder, folder_params) do
      render(conn, "show.json", folder: folder)
    end
  end

  def delete(conn, %{"id" => id}) do
    folder = Folders.get_folder!(id)

    with {:ok, %Folder{}} <- Folders.delete_folder(folder) do
      send_resp(conn, :no_content, "")
    end
  end

  def add_child(conn, %{"parent_id" => parent_id, "child" => child}) do
    with {:ok, %Folder{} = folder} <- Folders.add_child(child, parent_id) do
      render(conn, "show.json", folder: folder)
    end
  end

  def search(conn, %{"search" => search}) do
    folders = Folders.search(search)
    render(conn, "index.json", folders: folders)
  end
end
