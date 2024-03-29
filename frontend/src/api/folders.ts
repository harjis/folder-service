import { options, url } from "./common";

export type Folder = {
  id: number;
  insertedAt: string;
  lft: number;
  name: string;
  parentId: number | null;
  rgt: number;
  updatedAt: string;
};

export const fetchRoots = (): Promise<Folder[]> =>
  fetch(`${url}/folders/roots`, options()).then((response) => response.json());

export const fetchChildren = (folderId: number): Promise<Folder[]> =>
  fetch(
    `${url}/folders/children?parent_id=${folderId}`,
    options()
  ).then((response) => response.json());

export const searchFolders = (search: string): Promise<Folder[]> =>
  fetch(`${url}/folders/search?search=${search}`, options()).then((response) =>
    response.json()
  );
