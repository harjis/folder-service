import { useState } from "react";
import AwesomeDebouncePromise from "awesome-debounce-promise";
import { Folder, searchFolders } from "../api/folders";
import { useRecoilCallback, useRecoilValue } from "recoil";
import { searchFoldersAtom, searchRootFoldersAtom } from "../atoms/folders";

const debouncedSearch = AwesomeDebouncePromise(searchFolders, 500);

export type Return = {
  isSearching: boolean;
  search: string;
  onSearch: (search: string) => void;
  searchRootFolders: Folder[];
};
export const useSearchFolders = (): Return => {
  const [search, setSearch] = useState("");
  const searchRootFolders = useRecoilValue(searchRootFoldersAtom);

  const onSearch = useRecoilCallback(
    ({ set }) => async (newSearch: string) => {
      setSearch(newSearch);
      if (newSearch === "") {
        return;
      }
      const searchFolders = await debouncedSearch(newSearch);
      set(searchFoldersAtom, searchFolders);
    },
    []
  );

  return {
    isSearching: search !== "",
    search,
    onSearch,
    searchRootFolders,
  };
};
