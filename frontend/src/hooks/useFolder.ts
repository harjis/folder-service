import { useCallback, useEffect, useState } from "react";
import { useRecoilCallback, useRecoilState } from "recoil";

import { fetchChildren, Folder } from "../api/folders";
import { childrenAtom, loadedFoldersAtom } from "../atoms/folders";

type Props = {
  folder: Folder;
};
type Return = {
  children: Folder[];
  isCollapsed: boolean;
  toggleCollapsed: () => void;
};
export const useFolder = (props: Props): Return => {
  const { id: folderId } = props.folder;

  const [isCollapsed, setCollapsed] = useState(true);
  const toggleCollapsed = useCallback(
    () => setCollapsed((prevState) => !prevState),
    [setCollapsed]
  );

  const [loadedFolders, setLoadedFolders] = useRecoilState(loadedFoldersAtom);
  const [children, setChildren] = useRecoilState(childrenAtom(folderId));

  const loadChildren = useRecoilCallback(
    () => async () => {
      const fetchedChildren = await fetchChildren(folderId);
      setChildren(fetchedChildren);
      setLoadedFolders((prevLoadedFolders) => prevLoadedFolders.add(folderId));
    },
    [folderId]
  );

  useEffect(() => {
    if (!isCollapsed && !loadedFolders.has(folderId)) loadChildren();
  }, [folderId, isCollapsed, loadChildren, loadedFolders]);

  return { children, isCollapsed, toggleCollapsed };
};
