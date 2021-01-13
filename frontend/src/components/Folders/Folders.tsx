import React from "react";
import { useAsync } from "react-use";
import { fetchFolders } from "../../api/folders";

type FoldersChildrenByFolderId = { [key: number]: React.ReactNode[] };
type Props = {
  foldersChildrenByFolderId: FoldersChildrenByFolderId;
};
export const Folders: React.FC<Props> = (props) => {
  const { value: folders, error, loading } = useAsync(fetchFolders);

  if (loading) {
    return <div>Loading...</div>;
  }
  if (error) {
    return <div>Error: {error}</div>;
  }

  return (
    <ul>
      {folders?.map((folder) => (
        <li key={folder.id}>
          {folder.name}

          {renderFolderChildren(props.foldersChildrenByFolderId[folder.id])}
        </li>
      ))}
    </ul>
  );
};

function renderFolderChildren(folderChildren: React.ReactNode[] | undefined) {
  if (folderChildren === undefined) {
    return null;
  }
  return (
    <ul>
      {folderChildren.map((child) => (
        <li>{child}</li>
      ))}
    </ul>
  );
}
