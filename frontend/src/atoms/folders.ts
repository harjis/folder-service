import { atom, atomFamily, selector, selectorFamily } from "recoil";

import { fetchFolder, fetchRoots, Folder } from "../api/folders";

export const rootsAtom = atom({
  key: "folders/roots",
  default: selector({
    key: "folders/roots/default",
    get: () => {
      return fetchRoots();
    },
  }),
});

export const loadedFoldersAtom = atom({
  key: "folders/loadedFolders",
  default: new Set(),
});

export const childrenAtom = atomFamily<Folder[], number>({
  key: "folders/childrenIds",
  default: [],
});

export const folderAtom = atomFamily<Folder, number>({
  key: "folders/folderAtom",
  default: selectorFamily({
    key: "folders/folderAtom/default",
    get: (folderId) => () => fetchFolder(folderId),
  }),
});
