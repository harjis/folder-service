defmodule Backend.FoldersGenerateTest do
  use Backend.DataCase

  alias Backend.Folders

  describe "generate" do
    test "generates folders" do
      Folders.generate()
      generated_folders = Folders.list_folders()
      assert length(generated_folders) == 7
    end
  end
end
