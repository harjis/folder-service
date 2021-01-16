defmodule Backend.Folders.Generate do
  alias Backend.Folders
  alias Backend.Folders.Folder

  def generate(depth, items_on_level) do
    {:ok, root} = Folders.create_root(%{name: "Root"})

    generate([root], depth, items_on_level, 1)
  end

  defp generate(folders, depth, items_on_level, current_depth) do
    Enum.map(folders, fn current_folder ->
      children = generate_children(current_folder, current_depth, items_on_level)

      if current_depth < depth do
        generate(children, depth, items_on_level, current_depth + 1)
      end
    end)
    {:ok, "Generate done!"}
  end

  defp generate_children(parent, current_depth, items_on_level) do
    Enum.map(1..items_on_level, fn item_no ->
      {:ok, created_child} =
        Folders.add_child(
          %{name: "Child item no. #{item_no} parent_id: #{parent.id} depth: #{current_depth}"},
          parent.id
        )

      created_child
    end)
  end
end
