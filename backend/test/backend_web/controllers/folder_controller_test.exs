defmodule BackendWeb.FolderControllerTest do
  use BackendWeb.ConnCase

  alias Backend.Folders
  alias Backend.Folders.Folder

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  def fixture(:root) do
    {:ok, folder} = Folders.create_root(@create_attrs)
    folder
  end

  def fixture(:child, attrs, parent_id) do
    {:ok, folder} = Folders.add_child(attrs, parent_id)
    folder
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "root" do
    setup [:create_root]

    test "renders root folders when there are root folders", %{conn: conn, folder: %{id: root_id}} do
      add_child(root_id)
      conn = get(conn, Routes.folder_path(conn, :roots))
      assert [%{"id" => id}] = json_response(conn, 200)
    end
  end

  describe "children" do
    setup [:create_root]

    test "renders root folders when there are root folders", %{conn: conn, folder: %{id: root_id}} do
      {:ok, folder: %{id: child_id}} = add_child(root_id)
      conn = get(conn, Routes.folder_path(conn, :children), parent_id: root_id)
      assert [%{"id" => child_id}] = json_response(conn, 200)
    end
  end

  describe "update folder" do
    setup [:create_root]

    test "renders folder when data is valid", %{conn: conn, folder: %Folder{id: id} = folder} do
      conn = put(conn, Routes.folder_path(conn, :update, folder), folder: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)

      conn = get(conn, Routes.folder_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "some updated name"
             } = json_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, folder: folder} do
      conn = put(conn, Routes.folder_path(conn, :update, folder), folder: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete folder" do
    setup [:create_root]

    test "deletes chosen folder", %{conn: conn, folder: folder} do
      conn = delete(conn, Routes.folder_path(conn, :delete, folder))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.folder_path(conn, :show, folder))
      end
    end
  end

  describe "add child" do
    setup [:create_root]

    @create_child %{
      name: "Child name"
    }

    test "creates a child for folder", %{conn: conn, folder: %Folder{id: parent_id} = _} do
      conn =
        post(conn, Routes.folder_path(conn, :add_child),
          parent_id: parent_id,
          child: @create_child
        )

      assert %{"name" => "Child name", "parentId" => parent_id} = json_response(conn, 200)
    end
  end

  describe "search" do
    setup [:create_root]

    test "returns matching folders", %{conn: conn, folder: %{id: root_id}} do
      {:ok, folder: %{id: child_id}} = add_child(root_id)
      conn = get(conn, Routes.folder_path(conn, :search), search: "Child")

      response = json_response(conn, 200)
      assert length(response) == 2
    end
  end

  defp create_root(_) do
    folder = fixture(:root)
    {:ok, folder: folder}
  end

  defp add_child(parent_id) do
    folder = fixture(:child, %{name: "Child"}, parent_id)
    {:ok, folder: folder}
  end
end
