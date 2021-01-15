defmodule Backend.FoldersTest do
  use Backend.DataCase

  alias Backend.Folders

  describe "folders" do
    alias Backend.Folders.Folder

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def root_folder_fixture(attrs \\ %{}) do
      {:ok, folder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Folders.create_root()

      folder
    end

    def child_folder_fixture(attrs \\ %{}, parent_id) do
      {:ok, folder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Folders.add_child(parent_id)

      folder
    end

    test "list_folders/0 returns all folders" do
      folder = root_folder_fixture()
      assert Folders.list_folders() == [folder]
    end

    test "list_folders/1 returns all folders by name" do
      name = "Folder"
      root = root_folder_fixture(%{name: "#{name} 1"})
      folder2 = child_folder_fixture(%{name: "#{name} 2"}, root.id)
      _folder3 = child_folder_fixture(%{name: "Views 1"}, root.id)
      updated_root = Folders.get_folder!(root.id)
      assert Folders.list_folders(name) == [folder2, updated_root]
    end

    test "list_roots/0 returns all roots" do
      root = root_folder_fixture()
      root2 = root_folder_fixture()
      assert Folders.list_roots() == [root, root2]
    end

    test "list_children/0 returns all descendants for target" do
      root1 = root_folder_fixture()
      root2 = root_folder_fixture()
      child = child_folder_fixture(%{name: "Child 1 Root 1"}, root1.id)
      child_folder_fixture(%{name: "Child 1 Child 1"}, child.id)
      child_folder_fixture(%{name: "Child 1 Root 2"}, root2.id)

      reloaded_child = Folders.get_folder!(child.id)

      assert Folders.list_children(root1.id) == [reloaded_child]
    end

    test "get_folder!/1 returns the folder with given id" do
      folder = root_folder_fixture()
      assert Folders.get_folder!(folder.id) == folder
    end

    test "update_folder/2 with valid data updates the folder" do
      folder = root_folder_fixture()
      assert {:ok, %Folder{} = folder} = Folders.update_folder(folder, @update_attrs)
      assert folder.name == "some updated name"
    end

    test "update_folder/2 with invalid data returns error changeset" do
      folder = root_folder_fixture()
      assert {:error, %Ecto.Changeset{}} = Folders.update_folder(folder, @invalid_attrs)
      assert folder == Folders.get_folder!(folder.id)
    end

    test "delete_folder/1 deletes the folder" do
      folder = root_folder_fixture()
      assert {:ok, %Folder{}} = Folders.delete_folder(folder)
      assert_raise Ecto.NoResultsError, fn -> Folders.get_folder!(folder.id) end
    end

    test "change_folder/1 returns a folder changeset" do
      folder = root_folder_fixture()
      assert %Ecto.Changeset{} = Folders.change_folder(folder)
    end

    test "add_root/1 with valid data creates a root folder" do
      {:ok, root_folder} = Folders.create_root(%{name: "root"})
      assert root_folder.parent_id == nil
      assert root_folder.name == "root"
    end

    test "add_root/1 with invalid data returns error changeset" do
      {:error, changeset} = Folders.create_root(%{name: nil})
      assert Map.has_key?(Enum.into(changeset.errors, %{}), :name)
    end

    test "add_child/2 with valid data creates a child node" do
      {:ok, root_folder} = Folders.create_root(%{name: "root"})
      {:ok, child_node} = Folders.add_child(%{name: "child node"}, root_folder.id)
      assert child_node.parent_id == root_folder.id
      assert child_node.name == "child node"
    end

    test "add_child/2 with invalid data returns error changeset" do
      {:ok, root_folder} = Folders.create_root(%{name: "some name"})
      {:error, changeset} = Folders.add_child(%{name: nil}, root_folder.id)
      assert Map.has_key?(Enum.into(changeset.errors, %{}), :name)
    end

    test "add_to_left/2 with valid data creates a node on targets left side" do
      {:ok, root_folder} = Folders.create_root(%{name: "root"})
      {:ok, child_node} = Folders.add_child(%{name: "right node"}, root_folder.id)
      {:ok, left_node} = Folders.add_to_left(%{name: "left node"}, child_node.id)
      assert left_node.parent_id == root_folder.id
      assert left_node.name == "left node"
    end

    test "add_to_left/2 with invalid data returns error changeset" do
      {:ok, root_folder} = Folders.create_root(%{name: "some name"})
      {:error, changeset} = Folders.add_to_left(%{name: nil}, root_folder.id)
      assert Map.has_key?(Enum.into(changeset.errors, %{}), :name)
    end

    test "add_to_right/2 with valid data creates a node on targets right side" do
      {:ok, root_folder} = Folders.create_root(%{name: "root"})
      {:ok, child_node} = Folders.add_child(%{name: "left node"}, root_folder.id)
      {:ok, left_node} = Folders.add_to_right(%{name: "right node"}, child_node.id)
      assert left_node.parent_id == root_folder.id
      assert left_node.name == "right node"
    end

    test "add_to_right/2 with invalid data returns error changeset" do
      {:ok, root_folder} = Folders.create_root(%{name: "some name"})
      {:error, changeset} = Folders.add_to_right(%{name: nil}, root_folder.id)
      assert Map.has_key?(Enum.into(changeset.errors, %{}), :name)
    end
  end
end
