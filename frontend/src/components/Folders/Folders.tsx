import React from "react";

import s from "./Folders.module.css";

import * as AuthStore from "../../stores/AuthStore";
import { Folder } from "./Folder/Folder";
import { ItemsByFolderId } from "../../types";
import { Input } from "../Input";
import { useRootFolders } from "../../hooks/useRootFolders";

type PropsFromAuthenticationService = {
  accessToken: string;
  logout: () => Promise<void>;
};
type OwnProps = {
  itemsByFolderId: ItemsByFolderId;
};
const Folders: React.FC<PropsFromAuthenticationService & OwnProps> = (
  props
) => {
  AuthStore.setAccessToken(props.accessToken);
  const { roots, search, onSearch, isSearching } = useRootFolders();

  return (
    <div>
      <Input value={search} onChange={onSearch} />
      <ul className={s.container}>
        {roots.map((root) => (
          <Folder
            key={root.id}
            folder={root}
            itemsByFolderId={props.itemsByFolderId}
            isSearching={isSearching}
            search={search}
          />
        ))}
      </ul>
    </div>
  );
};

// Do not change this. Module federation will break
export default Folders;
