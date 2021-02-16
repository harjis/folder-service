defmodule Backend.FoldersSearchTest do
  use Backend.DataCase

  alias Backend.Folders

  import Backend.FolderFixtures

  describe "search" do
    test "returns folder tree for matching elements" do
      root = root_folder_fixture(%{name: "Root"})
      child = child_folder_fixture(%{name: "Child 1"}, root.id)
      child_folder_fixture(%{name: "Child 2"}, root.id)
      reloaded_root = Folders.get_folder!(root.id)
      reloaded_child = Folders.get_folder!(child.id)
      tree = Folders.search("Child 1")
      assert tree == [reloaded_child, reloaded_root]
    end

    test "works with deep tree" do
      root = root_folder_fixture(%{name: "Root"})
      child1 = child_folder_fixture(%{name: "Child 1"}, root.id)
      child11 = child_folder_fixture(%{name: "Child 11"}, child1.id)
      child_folder_fixture(%{name: "Child 2"}, root.id)
      reloaded_root = Folders.get_folder!(root.id)
      reloaded_child1 = Folders.get_folder!(child1.id)
      reloaded_child11 = Folders.get_folder!(child11.id)
      tree = Folders.search("Child 11")

      assert tree == [reloaded_child11, reloaded_root, reloaded_child1]
    end

    test "only returns unique elements" do
      root = root_folder_fixture(%{name: "Root"})
      child1 = child_folder_fixture(%{name: "Child 1"}, root.id)
      child11 = child_folder_fixture(%{name: "Child 11"}, root.id)
      child_folder_fixture(%{name: "Child 2"}, root.id)
      reloaded_root = Folders.get_folder!(root.id)
      reloaded_child1 = Folders.get_folder!(child1.id)
      reloaded_child11 = Folders.get_folder!(child11.id)
      tree = Folders.search("Child 1")

      assert tree == [reloaded_child1, reloaded_root, reloaded_child11]
    end
  end
end
