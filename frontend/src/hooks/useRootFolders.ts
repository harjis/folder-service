import { useEffect } from "react";
import { useRecoilCallback, useRecoilValue } from "recoil";

import { Folder, fetchRoots as fetchRootsApi } from "../api/folders";
import { foldersAtom, rootFoldersAtom } from "../atoms/folders";
import { useSearchFolders, Return as SearchReturn } from "./useSearchFolders";

type Return = {
  isSearching: SearchReturn["isSearching"];
  onSearch: SearchReturn["onSearch"];
  roots: Folder[];
  search: SearchReturn["search"];
};
export const useRootFolders = (): Return => {
  const { isSearching, search, onSearch, searchRootFolders } = useSearchFolders();
  const roots = useRecoilValue(rootFoldersAtom);

  const fetchRoots = useRecoilCallback(
    ({ set }) => async () => {
      const roots = await fetchRootsApi();
      set(foldersAtom, (prevFolders) => prevFolders.concat(roots));
    },
    []
  );

  useEffect(() => {
    fetchRoots();
  }, [fetchRoots]);

  return {
    isSearching,
    onSearch,
    roots: isSearching ? searchRootFolders : roots,
    search,
  };
};
