import { options, url } from "./common";

export type Folder = {
  id: number;
  name: string;
};

export function fetchFolders(): Promise<Folder[]> {
  return fetch(`${url}/folders`, options).then((response) => response.json());
}
