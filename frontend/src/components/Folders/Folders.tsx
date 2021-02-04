import React from "react";
import { useRecoilValue } from "recoil";

import * as AuthStore from "../../stores/AuthStore";
import { Folder } from "./Folder/Folder";
import { ItemsByFolderId } from "../../types";
import { rootsAtom } from "../../atoms/folders";

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
  const roots = useRecoilValue(rootsAtom);
  return (
    <ul>
      {roots.map((root) => (
        <Folder
          key={root.id}
          folder={root}
          itemsByFolderId={props.itemsByFolderId}
        />
      ))}
    </ul>
  );
};

export default Folders;
