defmodule Backend.Folders do
  @moduledoc """
  The Folders context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Folders.Folder

  @doc """
  Returns the list of folders.

  ## Examples

      iex> list_folders()
      [%Folder{}, ...]

  """
  def list_folders do
    Folder
    |> order_by([f], f.id)
    |> Repo.all
  end

  def list_folders(name) do
    Folder
    |> Folder.with_name(name)
    |> Repo.all()
  end

  @doc """
  Returns the list of root folders.

  ## Examples

      iex> list_roots()
      [%Folder{}, ...]

  """
  def list_roots() do
    Folder.roots()
  end

  def list_children(target_id) do
    target = get_folder!(target_id)
    Folder.children(target)
  end

  @doc """
  Gets a single folder.

  Raises `Ecto.NoResultsError` if the Folder does not exist.

  ## Examples

      iex> get_folder!(123)
      %Folder{}

      iex> get_folder!(456)
      ** (Ecto.NoResultsError)

  """
  def get_folder!(id), do: Repo.get!(Folder, id)

  @doc """
  Updates a folder.

  ## Examples

      iex> update_folder(folder, %{field: new_value})
      {:ok, %Folder{}}

      iex> update_folder(folder, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_folder(%Folder{} = folder, attrs) do
    folder
    |> Folder.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a folder.

  ## Examples

      iex> delete_folder(folder)
      {:ok, %Folder{}}

      iex> delete_folder(folder)
      {:error, %Ecto.Changeset{}}

  """
  def delete_folder(%Folder{} = folder) do
    Repo.delete(folder)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking folder changes.

  ## Examples

      iex> change_folder(folder)
      %Ecto.Changeset{source: %Folder{}}

  """
  def change_folder(%Folder{} = folder) do
    Folder.changeset(folder, %{})
  end

  @doc """
  Creates a root.

  ## Examples

      iex> create_root(%{field: value})
      {:ok, %Folder{}}

      iex> create_root(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_root(attrs \\ %{}) do
    Folder.create_root(attrs)
  end

  @doc """
  Creates a child node for parent.

  ## Examples

      iex> add_child(%{name: "name"}, 1)
      {:ok, %Folder{}}

      iex> add_child(%{name: nil}, 1)
      {:error, %Ecto.Changeset{}}

  """
  def add_child(attrs \\ %{}, parent_id) do
    parent = get_folder!(parent_id)
    Folder.add_child(attrs, parent)
  end

  @doc """
  Creates a node on the left side of target.

  ## Examples

      iex> add_to_left(%{field: value}, 1)
      {:ok, %Folder{}}

      iex> add_to_left(%{field: bad_value}, 1)
      {:error, %Ecto.Changeset{}}

  """
  def add_to_left(attrs \\ %{}, target_id) do
    target = get_folder!(target_id)
    Folder.add_to_left(attrs, target)
  end

  @doc """
  Creates a node on the right side of target.

  ## Examples

      iex> add_to_right(%{field: value}, 1)
      {:ok, %Folder{}}

      iex> add_to_right(%{field: bad_value}, 1)
      {:error, %Ecto.Changeset{}}

  """
  def add_to_right(attrs \\ %{}, target_id) do
    target = get_folder!(target_id)
    Folder.add_to_right(attrs, target)
  end

  defdelegate generate(depth \\ 2, items_on_level \\ 2), to: Backend.Folders.Generate
end
