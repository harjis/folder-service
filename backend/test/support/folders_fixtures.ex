defmodule Backend.FolderFixtures do
  alias Backend.Folders

  @valid_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def valid_folders_attrs, do: @valid_attrs
  def update_folders_attrs, do: @update_attrs
  def invalid_folders_attrs, do: @invalid_attrs

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
end
