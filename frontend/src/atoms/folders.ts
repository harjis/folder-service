import { atom, atomFamily, selectorFamily } from "recoil";

import { fetchChildren, fetchRoots, Folder } from "../api/folders";

export const rootsAtom = atom({
  key: "folders/roots",
  default: fetchRoots(),
});

export const childrenAtom = atomFamily<Folder[], number>({
  key: "folders/children",
  default: selectorFamily({
    key: "folders/children/default",
    get: (folderId) => () => fetchChildren(folderId),
  }),
});
