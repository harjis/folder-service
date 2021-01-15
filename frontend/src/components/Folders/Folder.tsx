import React from "react";
import { useRecoilValue } from "recoil";

import { Folder as FolderApiType } from "../../api/folders";
import { childrenAtom } from "../../atoms/folders";

type Props = {
  folder: FolderApiType;
};
export const Folder: React.FC<Props> = (props) => {
  const children = useRecoilValue(childrenAtom(props.folder.id));
  return (
    <>
      <li>{props.folder.name}</li>
      <ul>
        {children.map((child) => (
          <Folder folder={child} />
        ))}
      </ul>
    </>
  );
};
