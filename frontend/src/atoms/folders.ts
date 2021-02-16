import { atom, selector, selectorFamily } from "recoil";

import { Folder } from "../api/folders";

export const foldersAtom = atom<Folder[]>({ key: "folders", default: [] });
export const rootFoldersAtom = selector<Folder[]>({
  key: "folders/roots",
  get: ({ get }) =>
    get(foldersAtom).filter((folder) => folder.parentId === null),
});
export const childrenFoldersAtom = selectorFamily<Folder[], number>({
  key: "folders/children",
  get: (folderId) => ({ get }) =>
    get(foldersAtom).filter((folder) => folder.parentId === folderId),
});

export const searchFoldersAtom = atom<Folder[]>({
  key: "folders/search",
  default: [],
});
export const searchRootFoldersAtom = selector<Folder[]>({
  key: "folders/search/roots",
  get: ({ get }) =>
    get(searchFoldersAtom).filter((folder) => folder.parentId === null),
});
export const searchChildrenFoldersAtom = selectorFamily<Folder[], number>({
  key: "folders/search/children",
  get: (folderId) => ({ get }) =>
    get(searchFoldersAtom).filter((folder) => folder.parentId === folderId),
});
