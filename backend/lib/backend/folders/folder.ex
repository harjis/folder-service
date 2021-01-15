defmodule Backend.Folders.Folder do
  use AsNestedSet
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Backend.Repo
  alias Backend.Folders.Folder

  schema "folders" do
    field :name, :string
    field :parent_id, :id
    field :lft, :integer
    field :rgt, :integer

    timestamps()
  end

  def roots do
    AsNestedSet.roots(Folder, %{}) |> AsNestedSet.execute(Repo)
  end

  @doc false
  def changeset(folder, attrs) do
    folder
    |> cast(attrs, [:name, :lft, :rgt, :parent_id])
    |> validate_required([:name])
  end

  def create_root(attrs \\ %{}) do
    with {:ok} <- validate(attrs) do
      attrs
      |> map_to_struct
      |> AsNestedSet.create(:root)
      |> AsNestedSet.execute(Repo)
      |> to_tuple
    else
      err -> {:error, err}
    end
  end

  def add_child(attrs \\ %{}, %Folder{} = parent) do
    with {:ok} <- validate(attrs) do
      attrs
      |> map_to_struct
      |> AsNestedSet.create(parent, :child)
      |> AsNestedSet.execute(Repo)
      |> to_tuple
    else
      err -> {:error, err}
    end
  end

  def add_to_left(attrs \\ %{}, %Folder{} = target) do
    with {:ok} <- validate(attrs) do
      attrs
      |> map_to_struct
      |> AsNestedSet.create(target, :left)
      |> AsNestedSet.execute(Repo)
      |> to_tuple
    else
      err -> {:error, err}
    end
  end

  def add_to_right(attrs \\ %{}, %Folder{} = target) do
    with {:ok} <- validate(attrs) do
      attrs
      |> map_to_struct
      |> AsNestedSet.create(target, :right)
      |> AsNestedSet.execute(Repo)
      |> to_tuple
    else
      err -> {:error, err}
    end
  end

  def with_name(query \\ Folder, name) do
    query |> where([f], ilike(f.name, ^"%#{name}%"))
  end

  defp validate(attrs) do
    with %Ecto.Changeset{valid?: true} <- changeset(%Folder{}, attrs) do
      {:ok}
    else
      err -> err
    end
  end

  defp map_to_struct(attrs) do
    # ExConstructor.populate_struct is used because struct(Folder, attrs) ignores string keys
    ExConstructor.populate_struct(%Folder{}, attrs)
  end

  defp to_tuple(%Folder{} = folder) do
    {:ok, folder}
  end
end
