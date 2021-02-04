import React from "react";
import { Folder as FolderIcon } from "@material-ui/icons";

import s from "./Folder.module.css";
import { Folder as TFolder } from "../../../api/folders";
import { ItemsByFolderId } from "../../../types";
import { useFolder } from "../../../hooks/useFolder";
import { File } from "../File/File";

type Props = {
  folder: TFolder;
  itemsByFolderId: ItemsByFolderId;
};
export const Folder: React.FC<Props> = (props) => {
  const { children, isCollapsed, toggleCollapsed } = useFolder(props);
  return (
    <>
      <li className={s.folder} onClick={toggleCollapsed}>
        <span className={s.folderIcon}>
          <FolderIcon />
        </span>

        {props.folder.id}: {props.folder.name}
      </li>
      <ul>
        {!isCollapsed &&
          children.map((child) => (
            <Folder
              key={child.id}
              folder={child}
              itemsByFolderId={props.itemsByFolderId}
            />
          ))}
      </ul>
      {!isCollapsed &&
        props.itemsByFolderId[props.folder.id] &&
        props.itemsByFolderId[props.folder.id].map((node, index) => (
          <File key={index}>{node}</File>
        ))}
    </>
  );
};
