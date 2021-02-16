import { useCallback, useState } from "react";
import { useRecoilCallback, useRecoilValue } from "recoil";

import { fetchChildren, Folder } from "../api/folders";
import {
  childrenFoldersAtom,
  foldersAtom,
  searchChildrenFoldersAtom,
} from "../atoms/folders";

type Props = {
  folder: Folder;
  isSearching: boolean;
};
type Return = {
  children: Folder[];
  isCollapsed: boolean;
  toggleCollapsed: () => void;
};
export const useFolder = (props: Props): Return => {
  const { id: folderId } = props.folder;

  const children = useRecoilValue(childrenFoldersAtom(folderId));
  const searchChildren = useRecoilValue(searchChildrenFoldersAtom(folderId));
  const loadChildren = useRecoilCallback(
    ({ set }) => async (folderId: number) => {
      const fetchedChildren = await fetchChildren(folderId);
      set(foldersAtom, (prevFolders) => prevFolders.concat(fetchedChildren));
    },
    [folderId]
  );

  const [isCollapsed, setCollapsed] = useState(true);
  const toggleCollapsed = useCallback(() => {
    // Folder which doesn't have anything in it will always be refetched
    isCollapsed && children.length === 0 && loadChildren(folderId);
    setCollapsed((prevState) => !prevState);
  }, [children, folderId, isCollapsed, loadChildren]);

  return {
    children: props.isSearching ? searchChildren : children,
    isCollapsed: props.isSearching ? false : isCollapsed,
    toggleCollapsed,
  };
};
